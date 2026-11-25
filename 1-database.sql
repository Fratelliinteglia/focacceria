-- FOCACCERIA - passo 1: crea le tabelle e le regole di sicurezza.
-- Incolla tutto in Supabase > SQL Editor > New query > Run. Eseguilo UNA sola volta.

create table public.ruoli (
  user_id uuid primary key references auth.users(id) on delete cascade,
  ruolo text not null check (ruolo in ('admin','socio'))
);
alter table public.ruoli enable row level security;
create policy "ognuno legge il proprio ruolo" on public.ruoli
  for select to authenticated using (user_id = auth.uid());

create function public.is_member() returns boolean
  language sql security definer set search_path = public stable
  as $$ select exists (select 1 from public.ruoli where user_id = auth.uid()) $$;

create function public.is_admin() returns boolean
  language sql security definer set search_path = public stable
  as $$ select exists (select 1 from public.ruoli where user_id = auth.uid() and ruolo = 'admin') $$;

do $$
declare t text;
begin
  foreach t in array array['incassi','spese','fatture','fornitori'] loop
    execute format('create table public.%I (id text primary key, data jsonb not null, updated_at timestamptz not null default now())', t);
    execute format('alter table public.%I enable row level security', t);
    execute format('create policy "soci leggono" on public.%I for select to authenticated using (public.is_member())', t);
    execute format('create policy "soci inseriscono" on public.%I for insert to authenticated with check (public.is_member())', t);
    execute format('create policy "soci modificano" on public.%I for update to authenticated using (public.is_member()) with check (public.is_member())', t);
    execute format('create policy "solo admin elimina" on public.%I for delete to authenticated using (public.is_admin())', t);
    execute format('alter publication supabase_realtime add table public.%I', t);
  end loop;
end $$;

-- Archivio privato per PDF e foto delle fatture
insert into storage.buckets (id, name, public) values ('fatture', 'fatture', false)
  on conflict (id) do nothing;
create policy "soci leggono file" on storage.objects
  for select to authenticated using (bucket_id = 'fatture' and public.is_member());
create policy "soci caricano file" on storage.objects
  for insert to authenticated with check (bucket_id = 'fatture' and public.is_member());
create policy "solo admin elimina file" on storage.objects
  for delete to authenticated using (bucket_id = 'fatture' and public.is_admin());
