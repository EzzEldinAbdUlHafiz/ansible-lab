# Ansible Labs Documentation

---

## Lab 1: Inventory Setup
**Description:** 
This lab establishes the foundational AWS infrastructure and Ansible configuration. Two EC2 web servers and one database server were provisioned. A structured YAML inventory was created utilizing parent and child groups (`production`, `webservers`, `dbservers`). Connectivity was successfully verified via the `ping` module, and variable inheritance was tested by overriding the `server_role` variable for `web01` using `host_vars`.

![Ping all servers](<imgs/Screenshot from 2026-04-30 16-48-28.png>)
![Ping webservers group](<imgs/Screenshot from 2026-04-30 16-48-51.png>)
![Inventory variable inheritance web01](<imgs/Screenshot from 2026-04-30 16-49-09.png>)
![Inventory variable inheritance web02](<imgs/Screenshot from 2026-04-30 16-50-02.png>)

---

## Lab 2: Write Your First Playbook
**Description:** 
This lab transitions from ad-hoc commands to a declarative playbook (`site.yml`). The playbook automates a full Nginx web server setup, including package installation, dynamic configuration deployment via a Jinja2 template (`nginx.conf.j2`), and service management. The playbook was designed to be fully idempotent, utilizing a handler to restart Nginx only upon configuration changes. The bonus task was completed by implementing a `block/rescue` structure with the `uri` module to verify the HTTP 200 status code natively.

![Playbook execution - Initial Run](<imgs/Screenshot from 2026-04-30 17-11-59.png>)
![Playbook execution - Idempotency Test](<imgs/Screenshot from 2026-04-30 17-13-01.png>)
![Web01 Browser Verification](<imgs/Screenshot from 2026-04-30 17-18-40.png>)
![Web02 Browser Verification](<imgs/Screenshot from 2026-04-30 17-19-05.png>)

---

## Lab 3: Roles & Galaxy
**Description:** 
This lab focuses on modularity, reusability, and community integrations. The previous playbook was refactored into a standardized, self-contained Ansible Role generated via `ansible-galaxy init`. A community MySQL role (`geerlingguy.mysql`) was pulled via `requirements.yml`. Both roles were orchestrated in a master playbook, demonstrating variable overrides (changing the Nginx port to 8080). Finally, advanced logic was added to the custom role, utilizing `stat` and `when` to smartly skip redundant package checks, and `include_tasks` to modularize security configurations.

![Ansible Galaxy role installation](<imgs/Screenshot from 2026-04-30 17-50-32.png>)
![Master Playbook Execution - DB Setup](<imgs/Screenshot from 2026-04-30 19-32-02_2.png>)
![URI module test on port 8080](<imgs/Screenshot from 2026-04-30 19-33-39.png>)
![Bonus - Smart execution skipping nginx install](<imgs/Screenshot from 2026-04-30 20-19-02.png>)
![Bonus - Include tasks modularity](<imgs/Screenshot from 2026-04-30 20-19-52.png>)
