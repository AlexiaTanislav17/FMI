SELECT employee_id, last_name,salary*12 "ANNUAL SALARY"
FROM employees;

SELECT employee_id, last_name,salary*12
FROM employees;

describe jobs;
select * from jobs;

SELECT employee_id, last_name,salary*12 "ANNUAL SALARY"
FROM employees
WHERE salary*12>50000;

SELECT employee_id, last_name,salary*12 "ANNUAL SALARY"
FROM employees
WHERE salary*12>50000
AND employee_id<140
ORDER BY "ANNUAL SALARY" DESC;

SELECT employee_id, first_name || ' ' || Last_name
FROM employees;

SELECT sysdate
FROM dual;  --iti afiseaza data curenta

SELECT to_char(sysdate, 'DD/MM/YYYY')
FROM dual;  --iti afiseaza data curenta

SELECT to_char(sysdate, 'DAY/MONTH/YEAR')
FROM dual;  --iti afiseaza data curenta

--NUMELE LUNII IN CARE SA ANGAJAT FIECAE SLARIAT
SELECT to_char(hire_date, 'MONTH')
FROM employees;

--ORD DESCRESC TOTI ANGAJATII IN FUNCTIE DE COMSINIONUL LOR
SELECT employee_id,commission_pct
FROM employees
ORDER BY commission_pct DESC;

--ORD DESCRESC TOTI ANGAJATII IN FUNCTIE DE COMSINIONUL LOR CARE E DIF DE NULL
SELECT employee_id,nvl(commission_pct, 0) commission
FROM employees
ORDER BY commission DESC;

SELECT last_name
FROM employees
WHERE last_name LIKE '%a';   --daca ultm litera e a

SELECT last_name
FROM employees
WHERE last_name LIKE 'a%';   --daca prima litera e a

SELECT last_name
FROM employees
WHERE last_name LIKE '_a%';  --daca are a doua litera a

SELECT last_name
FROM employees
WHERE last_name LIKE '%a%';  --daca contine litera a

SELECT last_name, first_name
FROM employees
WHERE (department_id=30 OR manager_id=102)
AND last_name LIKE '%L%L%';             --daca numele conitne 2 de L

SELECT last_name, first_name
FROM employees
WHERE (lower(job_id) LIKE lower('%CLERK%') OR lower(job_id) LIKE lower('%REP%'))
AND salary NOT IN (3200,2700,2500,3100,6200);
--lower() converteste stringul in litere mici
--exista si upper() care le face litere mari

SELECT first_name, last_name
FROM employees
WHERE manager_id IS NULL;    --luam angajatii fara manager

SELECT first_name, last_name
FROM employees
WHERE department_id IS NULL;    --luam angajatii fara departament

SELECT department_id, department_name
FROM departments
WHERE manager_id IS NULL;    --luam departamentele fara manager

SELECT substr('primavara', 4) --iti ia de pe poz 4 pana la final
FROM dual;

SELECT substr('primavara',4,1) --iti ia de pe poz 4 un singur caracter
FROM dual;

SELECT substr('primavara',4,3) --iti ia de pe poz 4 inca 3 caracter
FROM dual;

SELECT substr('primavara',-4) --iti ia ultimele 4 caractere
FROM dual;

SELECT substr('primavara',length('primavara')-3) --iti ia ultimele 4 caractere
FROM dual;

SELECT rtrim('XXXprimavarXaXXXX','X')  --elimina de la dr caracterele x pana nu mai gaseste
FROM dual;   --XXXprimavarXa

SELECT rtrim('XXXprimavarXaXXXX','Xa') --elimina caracterele de la dr lui Xa pana la final
FROM dual;  --XXXprimavar

SELECT ltrim('XXXprimavarXaXXXX','X')  --elimina caracterele x de la stg
FROM dual;

SELECT trim(both 'X' from 'XXXprimavarXaXXXX')  -- nu exista trim singur doar cu both intre paranteze
FROM dual;

select replace('XXXprimavarXaXXX', 'X', '*')
from dual; --**primavar*a**

select translate('12 12 13 1', '12', 'ab')
from dual; --ab ab a3 a

select translate('12 12 13 1', '123', 'abc')
from dual; --ab ab ac a

select translate('12 12 13 1', '123 ', 'abcd')
from dual; --abdabdacda

select rtrim('Ionel Popescu        ',  ' ')
from dual;

SELECT first_name || ' ' || Last_name || ' castiga ' || salary || ' lunar dar doreste ' || salary*3 "SALARIU IDEAL"
FROM employees;

SELECT concat(concat(first_name, ' '),Last_name) || ' castiga ' || salary || ' lunar dar doreste ' || salary*3 "SALARIU IDEAL"
FROM employees;

SELECT concat(upper(substr(first_name,1,1)), lower(substr(first_name,2))) || ' ' || upper(last_name) 
|| ' ' || length(last_name)
FROM employees
WHERE (last_name LIKE 'J%' OR last_name LIKE 'M%' OR last_name LIKE '__a%')
ORDER BY length(last_name) DESC;

SELECT sysdate +2
FROM dual;  --iti intoarce ziua de peste 2 zile curente

SELECT add_months(sysdate, 2)
FROM dual;  --iti intoarce ziua de peste 2 luni curente

SELECT nvl(null,1) --verif daca primul arg e null si af 1 daca e null
FROM dual;

SELECT nvl(20,1)  --verif daca primul arg e null si af 1 daca e null, va af 20 pt ca nu e null
FROM dual;

SELECT nvl('a',1)  --a nu e null deci af a
FROM dual;

SELECT nvl(1,'2')  --af 1
FROM dual;

SELECT nvl(1,'ab')  --nu poti sa af sir de caractere, incaerca cinv in nr si nu poate
FROM dual;

SELECT employee_id, first_name, last_name, nvl(to_char(commission_pct),'nu are comision')
FROM employees;

SELECT employee_id, first_name, last_name, nvl2(commission_pct,to_char(commission_pct),'nu are comision')
FROM employees;

--CROSSJOIN   si    JOIN
SELECT e.*, d.*                       --aliasuri pt tabele, nu se folosesc in general
FROM employees e, departments d;

SELECT e.*, d.*
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

SELECT e.last_name || ' ' || e.first_name, d.department_name, e.department_id
FROM employees e 
JOIN departments d
ON e.departemnt_id = d.department_id;


SELECT e.last_name || ' ' || e.first_name, d.department_name, department_id
FROM employees e 
JOIN departments d
USING (department_id);

-- ori folosim ON PE FIECARE TABELA CU CONDITIE ORI FOLOSIM USING SI AND PT CONDITII
-- numele, salariu, orasul, tara si titlul jobului in care lucreaza angajatii condusi direct de managerul cu id 100
SELECT e.first_name, e.last_name, e.salary, j.job_title, c.country_name, l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
WHERE e.manager_id = 100;
-- la join oridnea conteaza ca altfel nu se leaga cum trb

SELECT e.first_name, e.last_name, e.salary, j.job_title, c.country_name, l.city
FROM employees e,jobs j,locations l,countries c, departments d
WHERE e.manager_id = 100
AND e.department_id = d.department_id
AND e.job_id = j.job_id
AND d.location_id = l.location_id
AND l.country_id = c.country_id;
-- cand folosesti where si and nu mai conteaza ordinea

--joburile care au salariu maxim mai mic decat salariul angajatului cu id 100
SELECT j.job_title, e.salary, j.max_salary
FROM jobs j, employees e
WHERE j.max_salary<e.salary
AND e.employee_id =100;

SELECT *
FROM jobs
WHERE max_salary<(SELECT salary FROM employees WHERE employee_id=100);    -- recomandat ca e mai usor

-- salariatii care au fost angajati dupa Gates
SELECT last_name, hire_date
FROM employees
WHERE hire_date>(SELECT hire_date FROM employees WHERE last_name = 'Gates');

--angajatii care lucreaza in acelasi departament cu cel putin un angajat al carui nume contine litera t
SELECT DISTINCT e.last_name, e.employee_id      --distinct iti alege din aceeasi tabele e pers dif 
FROM employees e, employees e2
WHERE e.department_id=e2.department_id
AND lower(e2.last_name) LIKE '%t%';

SELECT DISTINCT e.last_name, e.employee_id
FROM employees e
JOIN employees e2
ON (e.department_id=e2.department_id
AND lower(e2.last_name) LIKE '%t%');


SELECT employee_id, last_name, e.department_id, department_name
FROM employees e, departments d
WHERE (e.department_id = d.department_id);

SELECT employee_id, last_name, e.department_id, department_name
FROM employees e, departments d
WHERE (e.department_id(+) = d.department_id);
-- plusul  => departamentul exista dar nu are inf despre el deci completeaza cu null
-- af departamentele care nu au angajati dar exista practic

SELECT employee_id, last_name, e.department_id, department_name
FROM employees e, departments d
WHERE (e.department_id = d.department_id(+));
--af angajatii care nu au departament si completeaza cu null acolo

SELECT employee_id, last_name, e.department_id, department_name
FROM employees 
JOIN departments d
ON(e.department_id = d.department_id);

SELECT employee_id, last_name, e.department_id, department_name
FROM employees e 
left outer JOIN departments d
ON(e.department_id = d.department_id);
--left outer join returns all records from the left table (table1), and the matching records from the right table (table2). 
--The result is 0 records from the right side, 
--if there is no match.

SELECT employee_id, last_name, e.department_id, department_name
FROM employees e 
full outer JOIN departments d
ON(e.department_id = d.department_id);
-- full outer join keyword returns all records when there is a match in left (table1) or right (table2) table records.

SELECT employee_id, last_name, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+)    --inclusi ang care nu au departament
UNION
SELECT employee_id, last_name, department_name
FROM employee e, department d
WHERE e.department_id(+) = d.department_id;    --inclusiv depatamentele care nu au ang


--af codurile de tara, locatie, depart, ang inclusiv pt tarile, depart, locatiile 
--in care nu lucreaza nimeni
SELECT c.country_id, l.location_id, d.department_id, e.employee_id
FROM employees e, departments d, countries c, locations l
WHERE e.department_id(+) = d.department_id
AND d.location_id(+) = l.location_id
AND l.country_id(+) = c.country_id;


SELECT l.city, d.department_name dep
FROM locations l, departments d
WHERE l.location_id(+) = d.location_id
ORDER BY dep desc;


--SE CER CODURILE DEPART AL CAROR NUME CONTINE SIRUL "re" sau in care
-- lucreaza angajatii avand codul jobului "SA_REP"

SELECT d.department_id, d.department_name
FROM departments d, employees e
WHERE ((d.department_name LIKE '%re%') OR (e.job_id='SA%REP')); -- asta nu e bun


SELECT department_id
FROM departments
WHERE lower(department_name) LIKE '%re%'
UNION
SELECT department_id
FROM employees
WHERE lower(job_id)=lower('SA_REP');


--numele si salariul pt toti colegii din acelasi dep cu king
SELECT last_name, salary
FROM employees
WHERE department_id = ANY(SELECT department_id
                        FROM employees
                        WHERE lower(last_name) = 'king')
AND lower(last_name) <> 'king';  -- <> la fel cu !=
--any ii cere orice tip de data, daca nu puneam, mi-l punea string


--ASTA DE JOS NU E BUN LA UN EX DAR NU STIU CE ERA BUN
SELECT department_id, salary
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, salary
                                    FROM employees
                                    WHERE commission_pct IS NOT NULL)
AND department_id IN (SELECT department_id
                        FROM employees
                        WHERE commission_pct IS NOT NULL);
                        
                        
---------------lab 5 lipseste la mine, vad eu ---------------

--------------------------tema 1-----------------------------------

--1
--Sa se afiseze orasul si codul locatiei in care lucreaza in prezent salariatii angajati pe un job al carui titlu se termina 
--in "clerk" sau care se gaseste intr-o tara a carei denumire are pe a 4-a sau a 5-a pozitie litera "a".

--fara join
SELECT DISTINCT l.location_id, l.city
FROM employees e, jobs j, locations l, countries c, departments d
WHERE ((e.job_id = j.job_id) AND (c.country_id = l.country_id) 
AND (d.department_id = e.department_id) AND (d.location_id = l.location_id)
AND (lower(j.job_title) LIKE '%clerk'))
UNION
SELECT DISTINCT l.location_id, l.city
FROM locations l, countries c
WHERE c.country_name LIKE '____a%' OR c.country_name LIKE '___a%';



--2A
--Sa se afiseze numele complet, job-ul (titlul) actual si departamentul (numele) actual
--pentru angajatii care in prezent lucreaza intr-un departament si pe un job
--pe care au lucrat in trecut si alti salariati angajati dupa 29-Octombrie-1993.
--Se va tine cont atat de job, cat si de departament. Ordonati rezultatele 
--descrescator in functie de codul departamentului si  apoi dupa titlul jobului.

--SELECT DISTINCT e1.first_name, e1.last_name , j.job_title, d.department_name,e1.department_id
--FROM employees e1, departments d, jobs j,
--(SELECT e.employee_id, h.job_id, h.department_id FROM employees e 
--JOIN job_history h ON e.employee_id = h.employee_id
--WHERE e.hire_date > '29-10-1993'
--)e2
--WHERE e1.job_id = e2.job_id 
--AND e1.employee_id != e2.employee_id 
--AND e1.department_id = e2.department_id
--AND e1.department_id = d.department_id
--AND e1.job_id = j.job_id
--ORDER BY e1.department_id DESC, j.job_title DESC;


SELECT DISTINCT e1.first_name, e1.last_name , j.job_title, d.department_name,e1.department_id
FROM employees e1
LEFT JOIN departments d ON e1.department_id = d.department_id
LEFT JOIN jobs j ON e1.job_id = j.job_id
WHERE 
e1.department_id IN 
(SELECT DISTINCT h.department_id FROM employees e 
JOIN job_history h ON e.employee_id = h.employee_id
WHERE e.hire_date > '29-10-1993' )
AND
e1.job_id IN 
(SELECT DISTINCT h.job_id FROM employees e 
JOIN job_history h ON e.employee_id = h.employee_id
WHERE e.hire_date > '29-10-1993')
ORDER BY e1.department_id DESC, j.job_title DESC;




--2B
--Modificati cererea anterioara astfel incat sa se tina cont doar de lista job-urilor 
--pe care au lucrat in trecut angajatii indiferent de departamentul in care au lucrat. 
--Discutati diferentele aparute in cod, cat si despre rezultatele obtinute.


SELECT DISTINCT e1.first_name, e1.last_name , j.job_title, d.department_name,e1.department_id
FROM employees e1
LEFT JOIN departments d ON e1.department_id = d.department_id
LEFT JOIN jobs j ON e1.job_id = j.job_id
WHERE 
e1.job_id IN 
(SELECT DISTINCT h.job_id FROM employees e 
JOIN job_history h ON e.employee_id = h.employee_id
WHERE e.hire_date > '29-10-1993')
ORDER BY e1.department_id DESC, j.job_title DESC;

--
--SELECT DISTINCT e1.first_name, e1.last_name , j.job_title, d.department_name,e1.department_id
--FROM employees e1, departments d, jobs j,
--(SELECT e.employee_id, h.job_id FROM employees e 
--JOIN job_history h ON e.employee_id = h.employee_id
--WHERE e.hire_date > '29-10-1993'
--)e2
--WHERE e1.job_id = e2.job_id 
--AND e1.employee_id != e2.employee_id 
--AND e1.department_id = d.department_id(+)
--AND e1.job_id = j.job_id
--ORDER BY e1.department_id DESC, j.job_title DESC;


--2C
--Sa se afiseze numele complet, job-ul (titlul) actual si departamentul (numele) actual
--pentru angajatii care in prezent lucreaza intr-un departament sau pe un job
--pe care au lucrat in trecut si alti salariati angajati dupa 29-Octombrie-1993. 
--Discutati diferentele aparute in cod, cat si despre rezultatele obtinute.

--
--SELECT DISTINCT e1.first_name, e1.last_name , j.job_title, d.department_name,e1.department_id
--FROM employees e1, departments d, jobs j,
--(SELECT e.employee_id, h.job_id, h.department_id FROM employees e 
--JOIN job_history h ON e.employee_id = h.employee_id
--WHERE e.hire_date > '29-10-1993'
--)e2
--WHERE (e1.job_id = e2.job_id OR e1.department_id = e2.department_id)
--AND e1.employee_id != e2.employee_id 
--AND e1.department_id = d.department_id(+)
--AND e1.job_id = j.job_id(+)
--ORDER BY 1;
--ORDER BY e1.department_id DESC, j.job_title DESC;



SELECT DISTINCT e1.first_name, e1.last_name , j.job_title, d.department_name,e1.department_id
FROM employees e1
LEFT JOIN departments d ON e1.department_id = d.department_id
LEFT JOIN jobs j ON e1.job_id = j.job_id
WHERE 
e1.department_id IN 
(SELECT DISTINCT h.department_id FROM employees e 
JOIN job_history h ON e.employee_id = h.employee_id
WHERE e.hire_date > '29-10-1993' )
OR
e1.job_id IN 
(SELECT DISTINCT h.job_id FROM employees e 
JOIN job_history h ON e.employee_id = h.employee_id
WHERE e.hire_date > '29-10-1993')
ORDER BY e1.department_id DESC, j.job_title DESC;



--(department_id in (20,50,80) OR department_id IS NULL OR JOB_ID IN ('ST CLERK','ST CLERK','SA MAN','SA REP','MK REP')) AND EMPLOYEE_ID NOT IN (114, 122, 176, 176, 201)  ORDER BY FIRST_NAME




