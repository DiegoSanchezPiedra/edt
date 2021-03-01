#Coses que he fet

* afegir una altra ip al meu device per poder fer ip based virtual host
'''
ip a a ip/mx dev [dev]
'''

* crear el usuaris maria, pau i pere a /var/www/pass:
'''
htpasswd -c /var/www/pass maria
htpasswd /var/www/pass pau
htpasswd /var/www/pass pere
'''

* Crear el grup el qual permetrem l'accés:

'''
vim /var/www/grup
> alumnes: maria pau pere
'''
