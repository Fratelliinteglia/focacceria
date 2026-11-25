-- FOCACCERIA - passo 2: abilita te (admin) e il socio.
-- PRIMA crea i due utenti in Supabase > Authentication > Users > Add user (spunta "Auto Confirm User").
-- Poi sostituisci le due email qui sotto con quelle vere e premi Run.

insert into public.ruoli (user_id, ruolo)
select id, 'admin' from auth.users where email = 'LA-TUA-EMAIL@esempio.it';

insert into public.ruoli (user_id, ruolo)
select id, 'socio' from auth.users where email = 'EMAIL-DEL-SOCIO@esempio.it';
