# ldap

# Instalação

    apt install slapd ldap-utils ldapscripts

# Listar configuração

    sudo ldapsearch -Y EXTERNAL -H ldapi:/// -b "cn=config"

# Modificar configuração

    sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f <ldif>

# Criando indexes 

__=> olcDbIndex.ldif__

    dn: olcDatabase={1}mdb,cn=config
    changetype: modify
    replace: olcDbIndex
    olcDbIndex: cn pres,sub,eq
    -
    add: olcDbIndex
    olcDbIndex: sn pres,sub,eq
    -
    add: olcDbIndex
    olcDbIndex: uid pres,sub,eq
    -
    add: olcDbIndex
    olcDbIndex: displayName pres,sub,eq
    -
    add: olcDbIndex
    olcDbIndex: default sub
    -
    add: olcDbIndex
    olcDbIndex: uidNumber eq
    -
    add: olcDbIndex
    olcDbIndex: gidNumber eq
    -
    add: olcDbIndex
    olcDbIndex: mail,givenName eq,subinitial
    -
    add: olcDbIndex
    olcDbIndex: dc eq

# Aplicar o ldif

    sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f olcDbIndex.ldif

# Configurar o sufixo e o DN do root

__=> olcDatabase.ldif__ 

    dn: olcDatabase={1}mdb,cn=config
    changetype: modify
    replace: olcSuffix
    olcSuffix: o=FADESP
    -
    replace: olcRootDN
    olcRootDN: cn=admin,o=FADESP

# Aplicar ldif 

    sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f olcDatabase.ldif

# Mudar senha do admin
