
# Z80 Coil Winder


# Description

Read the UART messaging coming from the z80 and display the winder instructions on the screen using a raspberry pi

- [ ]  Finish updating Division 3 coil winding practice documentation
- [ ]  Deploy to other machines
- [ ]  update custom display stand

[Using Python Script to view Instructions](python_uart_to_web)

[Using Flutter to view Instructions](doc_display)

# Coil Winder Instruction Display


# Z80 Coil Winder

# Description

Read the UART messaging coming from the z80 and display the winder instructions on the screen using a raspberry pi

- [ ]  Finish updating Division 3 coil winding practice documentation
- [ ]  Deploy to other machines
- [ ]  update custom display stand

[Instruction Display - Task List](Z80%20Coil%20W%20ddb31/Instructio%20acf32.csv)

[Untitled](Z80%20Coil%20W%20ddb31/Untitled%20D%209b372.csv)

# Coil Winder Instruction Display

`Jared K West | September 23, 2021`

---

<!-- Table of Contents -->

- [Coil Winder Instruction Display](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#coil-winder-instruction-display)
    - [General Description](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#general-description)
    - [Objectives & Key Results](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#objectives--key-results)
        - [R&D: Department](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#rd-department)
        - [Computer Dept Tasks](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#computer-dept-tasks)
        - [Coil Dept Tasks](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#coil-dept-tasks)
    - [Project Documentation](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#project-documentation)
        - [R&D: Jared West](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#rd-jared-west)
    - [References](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#references)
        - [Markdown](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#markdown)
        - [Python](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#python)
        - [Linux](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#linux)
    - [Budgeting and Expenses](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#budgeting-and-expenses)
        - [Peripherals](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#peripherals)
        - [Computer](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#computer)
        - [Engineering Time](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#engineering-time)
    - [Winding Practices](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#winding-practices)
    - [Raspberry Pi](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#raspberry-pi)
        - [Calculate Engineering Time](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#calculate-engineering-time)
    - [Resources](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#resources)
        - [Markdown](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#markdown)
        - [Python](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#python)
        - [Linux](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#linux)

---

## General Description

This project will use a [Raspberry Pi 4B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b) to interact with a [HD64180Z](http://www.datasheet-pdf.com/PDF/HD64180Z-Datasheet-Hitachi-516367) `8-BIT CMOS` `Micro Processing Unit`. The interactiction will be to receive custom [Unicode](https://i.stack.imgur.com/SfxYs.png) `Serial Message` overt the `UART` port that is built in to a custom Howard Industries `HD648180Z CPU BOARD`.

<!-- LINKS -->

Once a `Serial Message` is received the [Raspberry Pi 4B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b) determines a `URL Path` to open with chromium-browser. Howard's Computer department has built a [Web Application](http://svr-webint1/WindingPractices/Home) that is hosted on our local `web server: //svr-webint1`

<!-- LINKS -->

---

<!-- BEGIN -->

## Objectives & Key Results

<!--<h3 style="display:inline;"> R&D Dept Tasks</h3>-->

### R&D: Department

Employee(s):
`[Jared West](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#jared-west)[Greg Bryant](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#greg-bryant)`

- [ ]  ***Management*:** Work with other departments to achieve the [project's objective](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#objectives--key-results)
- [ ]  ***[Project Proposal](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#project-proposal)* :**
- [ ]  [Working Prototype](#working-prototype) Deliver a working [Coil Winder Instruction Display](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#coil-winder-instruction-display) system that can be scaled automatically when the [Winding Practices](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#winding-practices) are updated by the `Coil Winding Department`.
- [ ]  ***[Documentation](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#markdown)* :** Make this project repeatable by another engineer without my support.
- [ ]  ***[RoadMap](notion://www.notion.so/src/roadmap.md)***

### Jared West's Assignments

### Computer Dept Tasks

`Employee: Dakota Shoemaker`

- [ ]  ***[Web Application](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#web-application)* :**
- [ ]  ***File Management*:**

### Coil Dept Tasks

`Div 1: Chiquita JonesDiv 2: Joash HolifieldDiv 3: Danny Rogers, Mike Graham, Dolores Washington, Shonda McKenzie`

- [ ]  ***Winding Practices*:**

### Media Dept Tasks

- [ ]  ***Video Shortening*:**

---

## Project Documentation

### R&D: Jared West

*Complilation of knowlege and instructions necessarry to repeat **[this project](notion://www.notion.so/Z80-Coil-Winder-ddb31278a1b345bfa466f00438121516#coil-winder-instruction-display)***

> View Jared's Project Guide
> 
> 
> ### Project Proposal
> 
> *Calculate overall projected cost so that a capital project can be created and approved*
> 
> 1. Excel Template
> 2. Quoting Equipment
> 3. Engineering Time
> 4. Submit for Approval
> 5. Approval
> 
> ### Getting Started: <sup>***[Python](https://www.python.org/)***</sup>
> 
> - ***Windows*** <sup>**[Python 3.9.7](https://www.python.org/downloads/release/python-397/)**</sup>
>     1. Installation
>     2. Command Prompt
>     3. Python (PIP)
>     4. Virtual Environments
>     5. Install Visual Studio Code
> - ***Raspberry Pi OS*** \* <sup> See **[Raspberry Pi: Operating System](notion://www.notion.so/src/RAD_JKW_DOCS.md)** </sup>
>     1. Installation
>     2. Terminal Commands
>     3. Python (PIP)
>     4. Virtual Environments
>     5. Install Visual Studio Code ***(VS-Code)***
> 
> ### Visual Studio Code
> 
> - ***Python***
>     1. Python
>     2. Pylance
> - ***Markdown***
>     1. Markdown All In One
> 
> ### Raspberrry Pi
> 
> - **Setup**_
> 1. Accesories
> 2. Operating System
> 3. Flash OS to SD Card
> 4. Initial Configuration
> 5. Update OS
> 6. Update Firmware
> -**Configuration**_
> 7. Networking
> 8. SSH
> 9. VNC
> 10. Remote Desktop
> 11. 
> 
> ***[View Jared's Project Guide](notion://www.notion.so/src/RAD_JKW_DOCS.md)***
> 

---

## References

Quick Links

### Markdown

- **Personal**
    - [First Attempt](notion://www.notion.so/src/FirstAttempt.md)
- **Visual Studio Code**
    - [Readme Example](notion://www.notion.so/src/vscode-Readme.md)
    - [Roadmap Example](notion://www.notion.so/src/vscode-Roadmap.md)

### Python

### Linux

