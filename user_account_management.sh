#!/bin/bash

#list of all existing users
user_list=$(/usr/bin/cat /etc/passwd | grep '/home/' | cut -d ':' -f1)

# Function to display a menu
display_menu(){

	echo  " User Account Management Menu"
	echo  "1. Create User"
	echo  "2. Delete User"
	echo  "3. Modify user"
	echo  "4. Change Password"
	echo  "5. Exit"
}

#Function to create a new user
create_user() {
	
	read -p "Enter the username: " username
	
	for user in $user_list
	do
		#Verify if username is empty
		if [[ -n "$username" ]] 
		then	
			#Verify if user in list is equal to username
			if [[ "$user" -eq "$username" ]]
			then
				sudo useradd $username
				echo -e "\e[32mUser $username created successfully.\e[0m"
				break
			else
				echo -e "\e[38;2;255;0;0m$username is already a user, you can´t create a user with the same name.\e[0m"
				break
			fi
		else	
			echo  -e "\e[38;2;255;0;0m The User name is empty, you should enter with a name.\e[0m" 
			break
		fi
	done
}

#Function to delete a user
delete_user(){
	
	user_list=$(/usr/bin/cat /etc/passwd | grep '/home/' | cut -d ':' -f1)

	echo -e "\e[38;2;255;0;0mUSERS IN ACTIVITY\e[0m"	
	echo -e "\e[33m$user_list\e[0m"

	read -p "Enter the username to delete: " username	
	
	for user in $user_list
	do
		if [[ -n "$username" ]]
		then
			echo $user
			if [[ $user -ne $username ]]
			then 
				sudo userdel -r $username
                                echo -e "\e[32mUser $username deleted successfully.\e[0m"
                                break
			else	
				echo -e "\e[38;2;255;0;0;0mYou can not delete $username, because does not exist!\e[0m"	
				break
			fi
		else
			echo  -e "\e[38;2;255;0;0m The User name is empty, you should enter with a name.\e[0m"
                        break
                fi
	done
}

#Function to modify user properties
modify_user() {

	read -p "Enter the username to modify: " username
	
	if [[ -z "$user" ]]
	then
		echo -e "\e[38;2;255;0;0;0m The chosen username does not exist. Please choose a valid user!\e[0m"
	else
		sudo usermod -a -G newgroup $username
		echo -e"\e[32mUser $username modified successfully.\e[0m"
	fi
}

#Function to change a user´s password
change_password(){

	read -p "Enter the username to change password: " username
	
	if [[ -z "$user" ]]
	then
		echo -e "\e[38;2;255;0;0;0m The chosen username does not exist. Please choose a valid user!\e[0m"
	else
		sudo passwd $username
		echo -e "\e[32mPassword for user $username chaged successfully.\e[0m"
	fi
}

#Main script
while true; do
	
	display_menu 
	read -p "33Enter your choice (1-5): " choice

	case $choice in 
		1) create_user ;;
		2) delete_user ;;
		3) modify_user ;;
		4) change_password ;;
		5) echo "Exiting..."; exit ;;
		*) echo "Invalid choice. Please enter a valid option." ;;
	esac
done

