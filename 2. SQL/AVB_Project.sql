-- =========================================================
-- EJERCICIO 1
-- Crea el esquema de la BBDD.
-- =========================================================
-- El esquema de la base de datos se ha creado importando el archivo
-- BBDD_Proyecto_shakila_sinuser.sql sobre la base de datos sql_project.

-- =========================================================
-- EJERCICIO 2
-- Muestra los nombres de todas las películas con una clasificación por edades de 'R'.
-- =========================================================

select f.title 
from film f 
where f.rating = 'R';

-- =========================================================
-- EJERCICIO 3
-- Encuentra los nombres de los actores que tengan un actor_id entre 30 y 40.
-- =========================================================

select 
	a.first_name, 
	a.last_name 
from actor a 
where a.actor_id between 30 and 40;

-- =========================================================
-- EJERCICIO 4
-- Obtén las películas cuyo idioma coincide con el idioma original.
-- =========================================================

select 
	f.title, 
	f.language_id, 
	f.original_language_id 
from film f 
where f.language_id = f.original_language_id;

-- =========================================================
-- EJERCICIO 5
-- Ordena las películas por duración de forma ascendente.
-- =========================================================

select 
	f.title, 
	f.length 
from film f 
order by f.length;

-- =========================================================
-- EJERCICIO 6
-- Encuentra el nombre y apellido de los actores que tengan 'ALLEN' en su apellido.
-- =========================================================

select 
	a.first_name, 
	a.last_name
from actor a 
where a.last_name like 'ALLEN';

-- =========================================================
-- EJERCICIO 7
-- Encuentra la cantidad total de películas en cada clasificación de la tabla film
-- y muestra la clasificación junto con el recuento.
-- =========================================================

select 
	f.rating, 
	count(*) as Total_Peliculas
from film f 
group by rating
order by total_peliculas desc;

-- =========================================================
-- EJERCICIO 8
-- Encuentra el título de todas las películas que son 'PG-13'
-- o tienen una duración mayor a 3 horas.
-- =========================================================

select 
	f.title,
	f.rating,
	f.length 
from film f 
where f.rating = 'PG-13'
	or f.length > 180;

-- =========================================================
-- EJERCICIO 9
-- Encuentra la variabilidad (por variabilidad entiendo Varianza) de lo que costaría reemplazar las películas.
-- =========================================================

select 
	variance(f.replacement_cost) as Coste_Reemplazo_varianza,
	stddev(f.replacement_cost) as Coste_Reemplazo_desviacion_estandar -- Muestro tambien la desviacion por si acaso.
from film f ;

-- =========================================================
-- EJERCICIO 10
-- Encuentra la mayor y menor duración de una película de nuestra BBDD.
-- =========================================================

select 
	max(f.length) as Max_Length,
	min(f.length) as Min_Length
from film f;

-- =========================================================
-- EJERCICIO 11
-- Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
-- =========================================================

select p.amount as Antepenultimo_Alquiler
from payment p
order by p.payment_date desc
offset 2
limit 1;

-- =========================================================
-- EJERCICIO 12
-- Encuentra el título de las películas en la tabla film que no sean ni 'NC-17' ni 'G'
-- en cuanto a su clasificación.
-- =========================================================

select 
	f.title,
	f.rating 
from film f 
where f.rating not in ('NC-17', 'G');

-- =========================================================
-- EJERCICIO 13
-- Encuentra el promedio de duración de las películas para cada clasificación
-- de la tabla film y muestra la clasificación junto con el promedio de duración.
-- =========================================================

select f.rating, avg(f.length) as Promedio_Duracion
from film f 
group by f.rating
order by f.rating;

-- =========================================================
-- EJERCICIO 14
-- Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
-- =========================================================

select 
	f.title, 
	f.length 
from film f 
where f.length > 180;

-- =========================================================
-- EJERCICIO 15
-- ¿Cuánto dinero ha generado en total la empresa?
-- =========================================================

select sum(p.amount) as Total_Generado
from payment p;

-- =========================================================
-- EJERCICIO 16
-- Muestra los 10 clientes con mayor valor de id.
-- =========================================================

select 
	c.customer_id, 
	c.first_name,
	c.last_name 
from customer c 
order by c.customer_id desc
limit 10;

-- =========================================================
-- EJERCICIO 17
-- Encuentra el nombre y apellido de los actores que aparecen en la película
-- con título 'Egg Igby'.
-- =========================================================

select 
	a.first_name,
	a.last_name 
from actor a 
join film_actor fa 
	on a.actor_id = fa.actor_id 
join film f 
	on fa.film_id = f.film_id 
where upper(f.title) = upper('Egg Igby');

-- =========================================================
-- EJERCICIO 18
-- Selecciona todos los nombres de las películas únicos.
-- =========================================================

select distinct f.title 
from film f 
order by f.title;

-- =========================================================
-- EJERCICIO 19
-- Encuentra el título de las películas que son comedias y tienen una duración
-- mayor a 180 minutos en la tabla film.
-- =========================================================

select 
	f.title, 
	f.length 
from film f 
join film_category fc 
	on f.film_id = fc.film_id
join category c 
	on fc.category_id = c.category_id 
where c."name" = 'Comedy'
	and f.length > 180;

-- =========================================================
-- EJERCICIO 20
-- Encuentra las categorías de películas que tienen un promedio de duración
-- superior a 110 minutos y muestra el nombre de la categoría junto con el promedio.
-- =========================================================

select c."name" as categoria, AVG(f.length) as promedio_duracion
from category c  
join film_category fc 
	on c.category_id  = fc.category_id 
join film f 
	on fc.film_id = f.film_id 
group by c."name" 
having AVG(f.length) > 110
order by promedio_duracion desc;

-- =========================================================
-- EJERCICIO 21
-- ¿Cuál es la media de duración del alquiler de las películas?
-- =========================================================

select AVG(r.return_date - r.rental_date) as Media_Duracion_Alquiler
from rental r 
where r.return_date is not null;

-- =========================================================
-- EJERCICIO 22
-- Crea una columna con el nombre y apellidos de todos los actores y actrices.
-- =========================================================

select 
	concat (a.first_name, ' ' , a.last_name) as Nombre_Completo
from actor a;

-- =========================================================
-- EJERCICIO 23
-- Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
-- =========================================================

select 
	DATE(r.rental_date) as dia, 
	count(*) as total_alquileres
from rental r
group by DATE(r.rental_date)
order by total_alquileres;

-- =========================================================
-- EJERCICIO 24
-- Encuentra las películas con una duración superior al promedio.
-- =========================================================

select 
	f.title,
	f.length 
from film f 
where f.length > (
	select avg(length)
	from film f
);

-- =========================================================
-- EJERCICIO 25
-- Averigua el número de alquileres registrados por mes.
-- =========================================================

select
	date_part('month', r.rental_date) as mes,
	count (*) as Total_Alquileres
from rental r 
group by mes
order by mes;

-- =========================================================
-- EJERCICIO 26
-- Encuentra el promedio, la desviación estándar y varianza del total pagado.
-- =========================================================

select 
	AVG(p.amount) as promedio,
	stddev(p.amount) as desviacion,
	variance(p.amount) as varianza
from payment p;

-- =========================================================
-- EJERCICIO 27
-- ¿Qué películas se alquilan por encima del precio medio?
-- =========================================================

select 
	f.title, 
	f.rental_rate 
from film f 
where f.rental_rate > 
(
	select AVG(f2.rental_rate)
	from film f2 
);

-- =========================================================
-- EJERCICIO 28
-- Muestra el id de los actores que hayan participado en más de 40 películas.
-- =========================================================

select 
	fa.actor_id, 
	count(fa.film_id) as Total_Films
from film_actor fa
group by actor_id 
having count(fa.film_id) > 40;

-- =========================================================
-- EJERCICIO 29
-- Obtener todas las películas y, si están disponibles en el inventario,
-- mostrar la cantidad disponible.
-- =========================================================

select 
	f.title,
	count(i.inventory_id) as cantidad_disponible
from film f 
left join inventory i 
	on f.film_id = i.film_id 
group by f.film_id, f.title
order by f.title;

-- =========================================================
-- EJERCICIO 30
-- Obtener los actores y el número de películas en las que ha actuado.
-- =========================================================

select 
	a.first_name, 
	a.last_name,
	count(fa.film_id) as numero_peliculas
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id 
group by a.actor_id, a.first_name, a.last_name
order by numero_peliculas desc;

-- =========================================================
-- EJERCICIO 31
-- Obtener todas las películas y mostrar los actores que han actuado en ellas,
-- incluso si algunas películas no tienen actores asociados.
-- =========================================================

select 
	f.title,
	a.first_name,
	a.last_name 
from film f 
left join film_actor fa 
	on f.film_id =fa.film_id 
left join actor a 
	on fa.actor_id = a.actor_id 
order by f.title , a.first_name , a.last_name;

-- =========================================================
-- EJERCICIO 32
-- Obtener todos los actores y mostrar las películas en las que han actuado,
-- incluso si algunos actores no han actuado en ninguna película.
-- =========================================================

select 
	a.first_name,
	a.last_name,
	f.title 
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id 
left join film f 
	on fa.film_id = f.film_id;

-- =========================================================
-- EJERCICIO 33
-- Obtener todas las películas que tenemos y todos los registros de alquiler.
-- =========================================================

select 
	f.title,
	r.rental_id,
	r.rental_date,
	r.return_date 
from film f 
left join inventory i 
	on f.film_id = i.film_id 
left join rental r 
	on i.inventory_id = r.inventory_id 
order by  f.title , r.rental_date;
	
-- =========================================================
-- EJERCICIO 34
-- Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
-- =========================================================

select 
	c.customer_id,
	c.first_name, 
	c.last_name, 
	sum(p.amount) as Total_Gastado
from customer c
join payment p 
	on c.customer_id = p.customer_id 
group by c.customer_id , c.first_name , c.last_name 
order by total_gastado desc
limit 5;

-- =========================================================
-- EJERCICIO 35
-- Selecciona todos los actores cuyo primer nombre es 'Johnny'.
-- =========================================================

select 
	a.actor_id,
	a.first_name,
	a.last_name 
from actor a 
where upper(a.first_name) = upper('Johnny'); 

-- =========================================================
-- EJERCICIO 36
-- Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
-- =========================================================

select 
	a.first_name as Nombre,
	a.last_name as Apellido
from actor a;

-- =========================================================
-- EJERCICIO 37
-- Encuentra el ID del actor más bajo y más alto en la tabla actor.
-- =========================================================

select
	min (a.actor_id) as min_id,
	max (a.actor_id) as max_id
from actor a;

-- =========================================================
-- EJERCICIO 38
-- Cuenta cuántos actores hay en la tabla “actor”.
-- =========================================================

select count (*) as total_actores
from actor a; 

-- =========================================================
-- EJERCICIO 39
-- Selecciona todos los actores y ordénalos por apellido en orden ascendente.
-- =========================================================

select 
	a.actor_id,
	a.first_name,
	a.last_name 
from actor a 
order by a.last_name;

-- =========================================================
-- EJERCICIO 40
-- Selecciona las primeras 5 películas de la tabla “film”.
-- =========================================================

select 
	f.film_id,
	f.title 
from film f 
order by f.film_id
limit 5;

-- =========================================================
-- EJERCICIO 41
-- Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre.
-- ¿Cuál es el nombre más repetido?
-- =========================================================

select 
	a.first_name, 
	count(*) as total_Actores
from actor a 
group by a.first_name 
order by total_actores desc, a.first_name;

-- Si solo queremos un resultado con el mas repetido añado el limit.

select 
	a.first_name,
	count(*) as total_Actores
from actor a 
group by a.first_name 
order by total_actores desc, a.first_name
limit 1;

-- =========================================================
-- EJERCICIO 42
-- Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
-- =========================================================

select 
	r.rental_id,
	r.rental_date, 
	c.first_name,
	c.last_name 
from rental r 
join customer c 
	on r.customer_id = c.customer_id 
order by r.rental_id;
	
-- =========================================================
-- EJERCICIO 43
-- Muestra todos los clientes y sus alquileres si existen, incluyendo
-- aquellos que no tienen alquileres.
-- =========================================================

select 
	c.customer_id,
	c.first_name,
	c.last_name,
	r.rental_id,
	r.rental_date 
from customer c 
left join rental r on c.customer_id = r.customer_id 
order by c.customer_id , r.rental_date;

-- =========================================================
-- EJERCICIO 44
-- Realiza un CROSS JOIN entre las tablas film y category.
-- ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
-- =========================================================

select 
	f.title, 
	c."name" as category_name
from film f 
cross join category c 
order by f.title , c."name";

/** En este caso, creo que la consulta no tiene ningun valor de analisis real. 
 Estamos generando todas las combinaciones posibles entre peliculas y categorias, 
 incluso si no existe relacion entre ellas, lo cual no tiene mucho sentido.
 Es valido para entender el cross join, pero para esta base de datos no es necesario. **/

-- =========================================================
-- EJERCICIO 45
-- Encuentra los actores que han participado en películas de la categoría 'Action'.
-- =========================================================

select distinct  
	a.first_name, 
	a.last_name 
from actor a 
join film_actor fa 
	on a.actor_id = fa.actor_id 
join film_category fc 
	on fa.film_id = fc.film_id 
join category c 
	on fc.category_id = c.category_id 
where upper(c."name") = upper('Action')
order by a.last_name , a.first_name;

-- =========================================================
-- EJERCICIO 46
-- Encuentra todos los actores que no han participado en películas.
-- =========================================================

select 
	a.first_name, 
	a.last_name 
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id 
where fa.film_id is null
order by a.last_name , a.first_name;

-- =========================================================
-- EJERCICIO 47
-- Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
-- =========================================================

select 
	a.first_name, 
	a.last_name, 
	count (fa.film_id) as total_films
from actor a
left join film_actor fa 
	on a.actor_id = fa.actor_id 
group by a.actor_id , a.first_name , a.last_name 
order by total_films desc, a.last_name, a.first_name;

-- Muy parecido al 30.

-- =========================================================
-- EJERCICIO 48
-- Crea una vista llamada “actor_num_peliculas” que muestre los nombres
-- de los actores y el número de películas en las que han participado.
-- =========================================================

create view actor_num_peliculas as
select 
	a.first_name, 
	a.last_name, 
	count (fa.film_id) as total_films
from actor a
left join film_actor fa 
	on a.actor_id = fa.actor_id 
group by a.actor_id , a.first_name , a.last_name 
order by total_films desc, a.last_name, a.first_name;

-- =========================================================
-- EJERCICIO 49
-- Calcula el número total de alquileres realizados por cada cliente.
-- =========================================================

select
	c.customer_id,
	c.first_name,
	c.last_name,
	count(r.rental_id) as total_Alquileres
from customer c 
left join rental r 
	on c.customer_id = r.customer_id 
group by c.customer_id, c.first_name , c.last_name 
order by total_alquileres desc, c.last_name, c.first_name;

-- =========================================================
-- EJERCICIO 50
-- Calcula la duración total de las películas en la categoría 'Action'.
-- =========================================================

select 
	sum (f.length) as duracion_total_action
from film f 
join film_category fc 
	on f.film_id = fc.film_id 
join category c 
	on fc.category_id = c.category_id 
where upper(c."name") = 'Action';

-- =========================================================
-- EJERCICIO 51
-- Crea una tabla temporal llamada “cliente_rentas_temporal” para
-- almacenar el total de alquileres por cliente.
-- =========================================================

-- Entiendo que una tabla temporal no pertenece al esquema public y por eso no se resaltan los colores en la query.
create temp table cliente_rentas_temporal as
select
    c.customer_id,
    c.first_name,
    c.last_name,
    count(r.rental_id) as total_alquileres
from customer c
left join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_alquileres desc;

-- Comprobar que funciona
select *
from clientes_rentas_temporal;

-- =========================================================
-- EJERCICIO 52
-- Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
-- películas que han sido alquiladas al menos 10 veces.
-- =========================================================

create temp table peliculas_alquiladas as
select
	f.film_id,
	f.title,
	count(r.rental_id) as total_alquileres
from film f
join inventory i
	on f.film_id = i.film_id 
join rental r 
	on i.inventory_id = r.inventory_id 
group by f.film_id, f.title 
having count(r.rental_id) >10;

-- Comprobar que funciona
select *
from peliculas_alquiladas
order by total_alquileres desc, title;

-- =========================================================
-- EJERCICIO 53
-- Encuentra el título de las películas que han sido alquiladas por el cliente
-- con el nombre ‘Tammy Sanders’ y que aún no se han devuelto.
-- Ordena los resultados alfabéticamente por título de película.
-- =========================================================

select f.title 
from customer c 
join rental r 
	on r.customer_id = r.customer_id 
join inventory i
	on r.inventory_id = i.inventory_id 
join film f 
	on i.film_id = f.film_id 
where upper(c.first_name) = upper('Tammy')
	and upper(c.last_name) = upper('Sanders')
	and r.return_date is null 
order by f.title;

-- =========================================================
-- EJERCICIO 54
-- Encuentra los nombres de los actores que han actuado en al menos una
-- película que pertenece a la categoría ‘Sci-Fi’.
-- Ordena los resultados alfabéticamente por apellido.
-- =========================================================

select distinct 
	a.first_name,
	a.last_name 
from actor a 
join film_actor fa 
	on a.actor_id = fa.actor_id 
join film_category fc 
	on fa.film_id = fc.film_id 
join category c 
	on fc.category_id = c.category_id 
where upper(c."name") = upper('Sci-Fi') 
order by a.last_name, a.first_name;

-- =========================================================
-- EJERCICIO 55
-- Encuentra el nombre y apellido de los actores que han actuado en
-- películas que se alquilaron después de que la película 'Spartacus Cheaper'
-- se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
-- =========================================================

select distinct 
	a.first_name,
	a.last_name 
from actor a 
join film_actor fa 
	on a.actor_id = fa.actor_id 
join inventory i  
	on fa.film_id = i.film_id 
join rental r 
	on i.inventory_id = r.inventory_id 
where r.rental_date > (
	select min (r2.rental_date)
	from film f 
	join inventory i2 
		on f.film_id = i2.film_id 
	join rental r2 
		on i2.inventory_id = r2.inventory_id 
	where upper(f.title) = upper('Spartacus Cheaper')
)
order by a.last_name, a.first_name;

-- =========================================================
-- EJERCICIO 56
-- Encuentra el nombre y apellido de los actores que no han actuado en
-- ninguna película de la categoría ‘Music’.
-- =========================================================

select 
	a.first_name,
	a.last_name 
from actor a 
where a.actor_id not in (
	select fa.actor_id 
	from film_actor fa 
	join film_category fc 
		on fa.film_id = fc.film_id 
	join category c 
		on fc.category_id = c.category_id
	where upper(c."name") = upper('Music')
)
order by a.first_name, a.last_name;

-- =========================================================
-- EJERCICIO 57
-- Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
-- =========================================================

select distinct f.title
from film f 
join inventory i 
	on f.film_id = i.film_id 
join rental r 
	on i.inventory_id = r.inventory_id 
where r.return_date is not null 
	and (r.return_date::date - r.rental_date::date) > 8
order by f.title;

-- =========================================================
-- EJERCICIO 58
-- Encuentra el título de todas las películas que son de la misma categoría
-- que 'Animation'.
-- =========================================================

select f.title
from film f 
join film_category fc 
	on f.film_id = fc.film_id 
where fc.category_id in(
	select c.category_id 
	from category c 
	where upper(c."name") = upper('Animation')
)
order by f.title;

-- =========================================================
-- EJERCICIO 59
-- Encuentra los nombres de las películas que tienen la misma duración que
-- la película con el título ‘Dancing Fever’.
-- Ordena los resultados alfabéticamente por título de película.
-- =========================================================

select f.title, f.length 
from film f 
where f.length = (
	select f2.length 
	from film f2
	where upper(f2.title) = upper('Dancing Fever') 
)
order by f.title;

-- =========================================================
-- EJERCICIO 60
-- Encuentra los nombres de los clientes que han alquilado al menos 7
-- películas distintas. Ordena los resultados alfabéticamente por apellido.
-- =========================================================

select 
	c.first_name, 
	c.last_name 
from customer c 
join rental r 
	on c.customer_id = r.customer_id 
join inventory i 
	on r.inventory_id = i.inventory_id 
group by c.customer_id, c.first_name, c.last_name 
having count(distinct i.film_id) >= 7
order by c.last_name, c.first_name;

-- =========================================================
-- EJERCICIO 61
-- Encuentra la cantidad total de películas alquiladas por categoría y
-- muestra el nombre de la categoría junto con el recuento de alquileres.
-- =========================================================

select
	c."name" as categoria,
	count(r.rental_id) as total_alquileres
from category c 
join film_category fc 
	on c.category_id = fc.category_id 
join film f 
	on fc.film_id = f.film_id 
join inventory i 
	on f.film_id = i.film_id 
join rental r 
	on i.inventory_id = r.inventory_id 
group by c."name" 
order by total_alquileres desc;

-- =========================================================
-- EJERCICIO 62
-- Encuentra el número de películas por categoría estrenadas en 2006.
-- =========================================================

select
	c."name" as categoria,
	count(f.film_id) as total_peliculas
from category c 
join film_category fc 
	on c.category_id = fc.category_id 
join film f 
	on fc.film_id = f.film_id 
where f.release_year = 2006
group by c."name" 
order by total_peliculas desc;

-- =========================================================
-- EJERCICIO 63
-- Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
-- =========================================================

select
	s.staff_id,
	s.first_name,
	s.last_name,
	s2.store_id 
from staff s 
cross join store s2 
order by s.staff_id, s2.store_id;

-- =========================================================
-- EJERCICIO 64
-- Encuentra la cantidad total de películas alquiladas por cada cliente y
-- muestra el ID del cliente, su nombre y apellido junto con la cantidad de
-- películas alquiladas.
-- =========================================================

select
	c.customer_id,
	c.first_name,
	c.last_name,
	count(r.rental_id) as total_peliculas_alquiladas
from customer c 
left join rental r
	on c.customer_id = r.customer_id 
group by c.customer_id, c.first_name, c.last_name 
order by total_peliculas_alquiladas desc, c.last_name, c.first_name;



















