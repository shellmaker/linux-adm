#!/bin/bash   
#*********************************************************************************   
#************************************* SCRIPT DE ADMINISTRACAO Verão 1.2 ***********   
#*********************************************************************************   
#   
# Notas :   
#   
# este  script pode ser modificado ao implementar novas funções   
# A indentação deve ser clara e os comandos comentados  
# o menu principal de administração está no final do script   
# este  script só pode ser executado enquanto root   
# em caso de adição de função pense em lembrar a função no menu principal ou no sub menu ao qual    
# ela é implementada   
# em caso de modificação a  interface deve ficar no máximo intuitiva   
#    
#   
#   
#   
#   
#*************************************************************************************   
#***********************************************Função gestão dos usuários   
#*************************************************************************************   
função gestão_usuário () {   
função criação_supp_usuário () { # função criação_supp_usuário   
echo -e " \033[31m Suprimir ou criar um usuário ? \033[00m"   
echo " Digitar para suprimir / Digitar c para criar:"   
read escolha  
if [ $escolha = "c" ] ;                     
then   
   echo "Entrar o login do usuário desejado:"   
   read user   
   adduser -a $user 2>/dev/null  # 2>/dev/null redireção para o  
    if [ $? -eq 0 ]     # lixo do comando precedente   
    then          # se o resultado é falso   
      echo -e "\033[31m O usuário $user foi criado! \033[00m"   
    else   
      echo -e "\033[31m falha, o usuário $user não foi criado, verificar os dados... \033[00m"   
    fi   
   echo "Pressionar na tecla <Entre> para voltar ao menu..."   
   read tecla     # leitura da tecla entrada   
   case $tecla in   

    )echo -e "\033[37m**** Retomada do script... ****\033[00m";; 


   esac   
else   
 if [ $escolha = "x" ] ;   
 then   
    echo "Dar o nome do usuário a suprimir:"   
    read utildel   
    userdel -r $utildel 2>/dev/null  # supressão com userdel -r   
      if [ $? -eq 0 ]    # e verificação  
      then        
           echo -e "\033[31m A supressão do usuário $utildel é confirmada \033[00m"   
      else      
           echo -e "\033[31m Falha, da supressão do usuário $utildel, verificar seus dados...\033[00m"   
      fi   
      echo "Pressionar sua tecla <Entre> para voltar ao  menu..."   
      read tecla   
      case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


      esac   
 else   
      exit 0   
 fi   
fi   
menu_usuário     # volta ao sub menu da função  
}     

função criação_sup_grupo () {   
echo -e " \033[31m Suprimir ou criar um grupo ? \033[00m"   
echo " Digitar x para Suprimir / Digitar c para criar :"            
read escolha   
if [ $escolha = "c" ] ;    
then   
   echo "Entrar o nome do grupo desejado:"   
   read grupo   
   grupoadd $grupo 2>/dev/null   
     if [ $? -eq 0 ]   
     then        
        echo -e "\033[31m O grupo $grupo foi criado  ! \033[00m"   
     else      
        echo -e "\033[31m Falha do grupo $grupo não foi criado, verificar seus dados... \033[00m"   
     fi   
       echo "Você quer verificar guardando o arquivo   
/etc/grupo ? (y/n)"   
 read rep   
   if [ $rep = "y" ] ;   
   then   
  vi /etc/grupo   # vi permite editar e cat é   
   else      # mais adaptado para esta   
         echo "Pressionar sobre a tecla <Entre> para voltar ao menu..."   
                read tecla   
                case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


  esac   
  menu_usuário   
          fi   
else   
 if [ $escolha = "x" ];    # segunda parte da escolha   
 then   
    echo "Dar o nome do grupo para  Suprimir :"   
    read grupo   
    grupodel $grupo2>/dev/null  # supressão com grupo de  
     if [ $? -eq 0 ]   
     then        
         echo -e "\033[31m A supressão  do grupo $grupo está confirmada \033[00m"   
     else      
        echo -e "\033[31m Falha, da supressão do grupo $grupo, verificar seus dados... \033[00m"   
     fi   
      
      echo "Você quer verificar guardando o arquivo /etc/grupo ? (y/n)"   
 read rep   
   if [ $rep = "y" ] ;   
   then   
  vi /etc/grupo   
   else   
         echo "Pressionar sobre a tecla <Entre> para voltar ao  menu..."   
                read tecla   
                case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


      esac   
  menu_usuário   # volta ao menu da sub função   
   fi   
 else   
   exit 0   
 fi   
fi   
menu_usuário     # lembrete do sub menu da função   
}   

função ver_usuário () {   
who -q                   # mostra todos os logins dos usuários    
echo "Pressionar sobre a tecla <Entre> para continuar..."         # conectados   
read tecla     
case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


esac   
menu_usuário   
}   

função adição_user_samba () {   
echo "Dar o nome do usuário a  implementar à Samba :"   
read nomee    
smbpasswd -a $nome 2>/dev/null  # adição  do usuário à samba por    
    if [ $? -eq 0 ]     # smbpasswd e verificação   
    then       
      echo -e "\033[31m O usuário $nome foi adicionado a Samba \033[00m"   
    else   
      echo -e "\033[31m falha do usuário $nome não foi adicionado a Samba, verificar o nome ... \033[00m"   
    fi   
echo "Pressionar a tecla <Entre>para continuar..."           
read tecla   
case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


esac   
menu_usuário   
}   

função adição_user_grupo () {   
echo "Dar o nome do usuário a adicionar no grupo :"    # Nota: a interface deve ser   
read nome   
echo "Dá o nome do grupo ao qual você quer implementar este usuário :"   
read grupo   
adduser $nome $grupo 2>/dev/null   # adição de um usuário à    
     if [ $? -eq 0 ]      # um grupo   
     then   
 echo -e "\033[31m O usuário $nome foi adicionada  ao a grupo $grupo \033[00m"   
     else   
 echo -e "\033[31m Falha o usuário $nome não foi adicionada ao grupo $grupo, verificar seus dados... \033[00m"   
     fi   
echo "Pressionar a tecla <Entre> para continuar..."   
read tecla   
case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


esac   
menu_usuário   
}   

função capacidade_user () {   
echo "O tamanho das pastas usuários é de:"   
du -s -h /home/*   
echo "Pressionar a tecla <Entre> para continuar..."   
read tecla   
case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


esac   
menu_usuário   
}   

função Menu_principal () {   
Menu   
}   

função menu_usuário () {     # menu da sub função   
clear         # "gestão dos usuários"   
echo ""   
echo -e "\033[36mProjet Linux                       eXia 2008 \033[00m"   
echo -e "           \033[36m3a  ano  RIR \033[00m "   
echo -e "                     \033[37m________________________________\033[00m "   
echo -e "                    \033[37m|    Gestão dos usuários    |\033[00m  "   
echo""   
echo -e "\033[33m*** MENU *** :\033[00m"   
echo""   
echo "1 - Criar / Suprimir um usuário"   
echo "2 - Criar / Suprimir um grupo"   
echo "3 - Veja os usuários conectados"   
echo "4 - Adicionar um usuário à Samba"   
echo "5 - Adição um usuário à um grupo"   
echo "6 - Ver o tamanho  dos pastas dos usuários"   
echo "7 - Voltar ao menu Principal"   
echo ""   
echo "Entre sua escolha :"   

read ESCOLHA      # leitura da escolha e chamado   
case $ESCOLHA in      # da função concernida   
  1)criação_sup_usuário;;   
  2)criação_sup_grupo;;   
  3)veja_usuário;;   
  4)adição_user_samba;;   
  5)adição_user_grupo;;   
  6)capacidade_user;;   
  7)Menu_principal;;   

    )exit 0;; 


esac   
}   
menu_usuário   
}        # FIM da no função   
        # gestão_usuário   
#**********************************************************************************   
#******************************************************Função matar um processo   
#**********************************************************************************   
função matar_proc () {   
ps ax --sort=tty,pid | more        # desfilamentos dos processos pouco a pouco   
echo " QUEIRA DIGITAR O (S)) "PID" DO (DOS) PROCESSO  A MATAR: " # para a utilização   de |more   
read PROCESS          da digitação antes do círculo PARA   
for TRUC in $PROCESS; do   
    kill -9 $TRUC 2>/dev/null        # parada dos processos para kill -9   
     if [ $? -eq 0 ]   
     then   
 echo -e "\033[31m O(s) processos $PROCESS foram parados \033[00m"   
     else   
 echo -e "\033[31m Falha do (s) processo $PROCESS não foram paradas, verificar o PID \033[00m"   
     fi   
done   
echo "Pressionar a tecla <Entre> para continuar..."   
read tecla   
case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


esac   
Menu   
}   

# ***********************************************************************************   
# *******************************************Função Recuperar os processos   
# ***********************************************************************************   
função recuperar_processo () {   
ps -aux >> processo_do_$(date +%d_%m_%y).log         # recup e sup do antigo arquivo de log por >>   
echo -e "\033[31m O arquivo Log de recuperação dos processos foi criado criado no desktop \033[00m"    
echo "Pressionar a tecla <Entre> para continuar..."   
read tecla   
case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


esac   
Menu   
}   

# ***********************************************************************************   
# ****************Função salvar / buscar pelo tamanho / nome arquivo ou diretório   
# ***********************************************************************************   
função sauv_busca_arquivo () {   
função sauv_resol_conf () {   
rsync -a /etc/resolv.conf /home/dyllan/Desktop/sauv_resol.conf_du_$(date +%d_%m_%y).log    # utilização de rsync para uma  
echo -e "\033[31m O resolv.conf do $(date +%d_%m_%y) foi salva no desktop \033[00m"                                                                        # salva distante mas não   
echo "Pressionar a tecla <Entre> para continuar..."        # apresentada aqui   
read tecla   
case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


esac   
menu_salv   
}   

função salv_supr_outro() {   
echo -e " \033[31m Suprimir ou Salvar? \033[00m"   
echo " Digitar x para Suprimir / Digitar s para salvar:"   
read escolha   
if [ $escolha = "s" ] ;    
then   
 echo "Entre o caminho do diretório a salvar "        
# solicitação do caminho relativo a sup ou   
 read caminho              # la salvar   
 echo "Entre o caminho do lugar onde você o salvou "   
 read dest   
 cp -r $caminho $dest 2>/dev/nulo                        # copia do diretório e todos os arquivos    
           if [ $? -eq 0 ]             # pela adição do -r para recursivo   
           then   
  echo -e "\033[31m O backup foi realizado \033[00m"   
         else   
         echo -e "\033[31m Falfa, o backup não foi realizado, verificar seus dados... \033[00m"   
           fi   
          echo "Pressionar a tecla <Entre> para continuar..."   
          read tecla   
   case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


          esac   
else   
 if [ $escolha = "x" ];     # 2a parte da escolha : la supressão   
 then   
        echo "Entre o caminho do diretório a Suprimir"   
 read chem   
 rm -r $chem 2>/dev/null   
        if [ $? -eq 0 ]   
        then   
  echo -e "\033[31m A supressão de $chem é confirmada \033[00m"   
      else   
         echo -e "\033[31m falha da supressão do $chem, verifique seus dados... \033[00m"   
        fi   
        echo "Pressionar a tecla <Entre> para continuar..."   
        read tecla   
 case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


        esac   
 else   
         exit 0   
 fi   
fi   
menu_sauv   
}     

função creer_rep () {   
echo "Qual é o nome do diretório ? (digite  o  nome) :"   
read nome   
if test -x $nome ;   
then   
  echo -e "\033[31m falha, o diretório já existe  !\033[00m"   
else   
  mkdir "$nome"   
  chmod 0733 $nome   
  echo -e "\033[31m A pasta $nome foi criado com os direitos no Desktop \033[00m"   
fi   
echo "Pressionar a tecla <Entre> para continuar..."   
read tecla   
case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


esac   
menu_sauv   
}   

função busca_tamanho () {   

echo -e "\033[31m A busca é orientada superior ou inferior ao tamanho do arquivo ? \033[00m"   
echo " Digitar s para superior / Digitar i para inferior:"   
read escolha   
if [ $escolha = "s" ] ;    
then   
   echo "Dar o tamanho mínimo (em kilo):"   
   read tamanho   
   echo -e "\033[37m Resultado com um tamanho mínimo de de $tamanho kilo :\033[00m"   
   find /* -size +$tamanho -print    # busca pelo tamanho orientado superior   
else        # então solicitação de um tamanho mínimo   
 if [ $escolha = "i" ];   
 then   
   echo "Dar o tamanho máximo onner (em kilo):"   
   read tamanho   
   echo -e "\033[37m Resultado com um tamanho máximo de de $tamanho e kilo :\033[00m"   
   find /* -size -$taille -print    # busca pelo tamanho orientado else        # então solicitação de um tamanho max   
   exit 0   
 fi   
fi   
echo "Pressionar a tecla <Entre> para continuar..."   
read tecla   
case $tecla in    

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


esac   
menu_sauv   
}   

função busca_nome () {   
echo " Qual é o arquivo ou diretório que você deseja buscar ?"   
read nome_fic   
echo -e "\033[37m resultado de sua busca :\033[00m"   
find /* -name $nome_fic      # busca por tudo / pelo nome   
echo "Pressionar a tecla <Entre> para continuar..." # esta busca pode demorar um pouco   
read tecla   
case $tecla in    

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


esac   
menu_sauv   
}   

função Menu_principal () {    # volta au menu Principal du script   
Menu   
}   

função menu_sauv () {   
clear    
echo ""   
echo -e "\033[36mProjeto Linux                       eXia 2008 \033[00m"   
echo -e "          \033[36m3° ano RIR \033[00m "   
echo -e "                     \033[37m______________________________\033[00m "   
echo -e "                    \033[37m|    backup e Busca   |\033[00m  "   
echo""   
echo -e "\033[33m*** MENU *** :\033[00m"   
echo""   
echo "1 - Salvar o arquivo resolv.conf"   
echo "2 - Salvar/suprimir um arquivo ou diretório"   
echo "3 - Criar um diretório"   
echo "4 - Busca de um  arquivo / diretório pelo seu tamanho"   
echo "5 - Busca de um  arquivo / diretório pelo seu nome "   
echo "6 - Voltar ao menu Principal"   
echo ""   
echo "Entre sua  escolha :"   

read ESCOLHA   
case $ESCOLHA in   
  1)sauv_resol_conf;;   
  2)sauv_supr_outro;;   
  3)criar_rep;;   
  4)busca_tamanho;;   
  5)busca_nome;;   
  6)Menu_principal;;   

    )exit 0;; 


esac   
}   
menu_sauv   
}   

#********************************************************************************   
#***********************************************Fonção Serviço Networking   
#********************************************************************************   
função networking () {   
função restart () {   
/etc/init.d/networking restart  # reinicialização do serviço networking   
echo "revenir au menu ? [y/n]"   
read resposta   
if [ $resposta = "y" ] ;    
then   
 menu   
else   
 echo "Pressionar a tecla <Entre> para continuar..."   
        read tecla   
        case $tecla in    

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


 esac   
 Menu   
fi   
}   

função stop () {   
/etc/init.d/networking stop   # parada do service networking por stop   
echo "voltar ao  menu ? [y/n]"   
read resposta   
if [ $resposta = "y" ] ;    
then   
 menu   
else   
 echo "Pressionar a tecla <Entre> para continuar..."   
        read tecla   
        case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


 esac   
 Menu   
fi   
}   

função start () {    # reinicialização do service networking por   
/etc/init.d/networking start   # start   
echo "voltar ao  menu ? [y/n]"   
read resposta   
if [ $resposta = "y" ] ;    
then   
 menu   
else   
 echo "Pressionar a tecla <Entre> para continuar..."   
        read tecla   
        case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


 esac   
 Menu   
fi   
}   

função edit () {   
vi /etc/resolv.conf    # vi permite editar em linha de comando   
clear       # le arquivo resolv.conf   
echo""   
echo "Voltar ao menu Administração do service Networking ? [y/n]"   
read resposta   
if [ $resposta = "y" ] ;    
then   
 menu   
else   
 echo "Pressionar a tecla <Entre> para continuar..."   
        read tecla   
        case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


 esac   
 Menu   
fi   
}   

função Menu_principal () {   
Menu   
}   

função menu () {    # configuração da aparência e da   
clear        # sintaxe do menu de administração   
echo ""      # du service Networking   
echo -e "\033[36mProjeot Linux                       eXia 2008 \033[00m"   
echo -e "           \033[36m3° ano  RIR \033[00m "   
echo -e "                     \033[37m____________________________________________\033[00m "   
echo -e "                    \033[37m|    Administração do serviço Networking    |\033[00m  "   
echo""   
echo -e "\033[33m*** MENU *** :\033[00m"   
echo""   
echo "1 - Restart"   
echo "2 - Stop"   
echo "3 - Start"   
echo "4 - Editar o arquivo resolv.conf"   
echo "5 - Voltar ao menu Principal"   
echo ""   
echo "Entre sua escolha :"   

read ESCOLHA   
case $ESCOLHA in   
  1)restart;;   
  2)stop;;   
  3)start;;   
  4)edit;;   
  5)Menu_principal;;   

    )exit 0;; 


esac   
}   
menu   
}   

#****************************************************************************   
#*************************************************Função fechar   
#****************************************************************************   
função fechar () {   
exit   
}   

#****************************************************************************   
#************************************************Fonção MENU   
#****************************************************************************   
função Menu () {    # concepção  do menu Principal do script que chama   
echo ""      # as sub funções   
echo -e "\033[36mProjeot Linux                       eXia 2008 \033[00m"   
echo -e "           \033[36m3° ano RIR \033[00m "   
echo -e "                         \033[37m _______________________________ \033[00m  "   
echo -e "                         \033[37m|    Script da administração |\033[00m  "   
echo""   
echo -e "\033[33m*** Menu Principal *** :\033[00m"   
echo""   
echo "1 - Gestão dos usuários"   
echo "2 - Gérer les processus"   
echo "3 - Recuperar os processos"   
echo "4 - Backup e Busca"   
echo "5 - Administração do serviço Networking"   
echo "6 - Fechar"   
echo ""   
echo "Entre sua  escolha :"   
read ESCOLHA     # leitura da escolha e chamada das funções   
case $ESCOLHA in   
  1)gestão_usuário;;   
  2)matar_proc;;   
  3)recuperar_processo;;   
  4)sauv_busca_arquivo;;   
  5)networking;;   
  6)quitter;;   

    )exit 0;; 


esac   
}       # FIM da função do menu Principal   
if [ ! 'id -u' = 0 ];     # Verificação   do identificador do user   
then       # se o idetinficador não foi aquele do root   
   echo -e "\033[31m Este script deve ser executado em root \033[00m"  # o script não foi executado,  
     echo""            # Senão acesso ao Menu principal   
     echo "**********************************************"   
     echo "Pressionar a tecla <Entre>para fechar..."   
     echo "**********************************************"   
     read tecla   
     case $tecla in   

    )echo -e "\033[37m**** Retomada  do script... ****\033[00m";; 


     esac   
   exit 0   
else   
   Menu   
fi  
