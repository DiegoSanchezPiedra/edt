#!/usr/bin/python
'''
Fes un script de nom calcula que en ser visitat amb una query string amb la forma 
?N=nombre&M=nombre&OP=operació retorni el resultat d’aplicar l’operació 
OP (suma, resta, multiplicació o divisió codificades amb un sol caràcter) als nombres N i M.
'''

'''
http://localhost/cgi-bin/calcula.py?N=4&M=3&OP=suma
'''
def calcula(llista,operador):
    '''
    funcio per calcular sum resta o div segons l'operador especificat
    '''
    res = 0
    if operador == 'suma':
        res = llista[0] + llista[1]
    elif operador == 'resta':
        res = llista[0] - llista[1]
    elif operador == 'division':
        res = llista[0] / llista[1]
    return res

import cgi, cgitb ; cgitb.enable()
form = cgi.FieldStorage()

#guardar los datos dados en la la query string de la url
n = int(form.getvalue('N'))
m = int(form.getvalue('M'))
op = form.getvalue('OP')

lista = [n,m]

if __name__=='__main__':
    print("Content-Type: text/plain\n\n")
    print(calcula(lista,op))