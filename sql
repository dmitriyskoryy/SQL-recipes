
workers = (
      {'id': 1, 'username': 'Pedro', 'age': 20},
      {'id': 2, 'username': 'Lesso', 'age': 37},
      {'id': 3, 'username': 'Michael', 'age': 28},
      {'id': 4, 'username': 'Picco', 'age': 20},
      {'id': 5, 'username': 'Nuchoo', 'age': 37},
      {'id': 6, 'username': 'Miko', 'age': 28},
)

resumes = (
    {'title': 'Developer Python Middle', 'salary': 120000, 'workload': 'fulltime', 'worker_id': 1},
    {'title': 'Developer Python Junior', 'salary': 37000, 'workload': 'fulltime', 'worker_id': 2},
    {'title': 'Developer Python Senior', 'salary': 180000, 'workload': 'fulltime', 'worker_id': 3},
    {'title': 'QA Engineer Python', 'salary': 250000, 'workload': 'parttime', 'worker_id': 4},
    {'title': 'Devops Engineer', 'salary': 300000, 'workload': 'parttime', 'worker_id': 5},
    {'title': 'Python Data Engineer', 'salary': 112000, 'workload': 'parttime', 'worker_id': 6},
)

# вывести сотрудников, которые входят в двойку лидеров по зарплате, учитывая режимы работы сотрудников (полный день, не полная занятость)
select tab1.username, tab1.salary, liders_salary
from
	(select
		w.username,
		r.salary,
		r.workload,
		rank() over (partition by r.workload ORDER BY r.salary DESC) as liders_salary
	from resumes as r
	join workers as w on w.id = r.worker_id) as tab1
where liders_salary < 3

Результат:
1 "Nuchoo"	300000	1
2 "Picco"	250000	2
3 "Michael"	180000	1
4 "Pedro"	120000	2

# с помощью подзапросов, вывести сотрудников у которых зарплата больше, чем средняя по таблице
select w.username, r.salary
from resumes as r
join workers as w on w.id = r.worker_id
where r.salary >= (select avg(r.salary)::int as comp
			from resumes as r
			join workers as w on w.id = r.worker_id)

Результат:
1 "Michael"	180000
2 "Picco"	250000
3 "Nuchoo"	300000
