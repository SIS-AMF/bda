# Aula 03

## Contents

- Functions


### Function


#### Basics
```sql
create function soma(integer) returns integer as
'
select $1 + $2;
'
language 'sql';
```

```sql
create function buscaFuncionarioIDDepto(integer) returns setof funcionarios as
'
select * from funcionarios as f
where f.depto_id = $1;
'
language 'sql';
```

- The `setof` is useful for returns more than one line.