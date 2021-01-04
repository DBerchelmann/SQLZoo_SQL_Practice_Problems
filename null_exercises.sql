# List the teachers who have NULL for their department.

SELECT name
FROM teacher
WHERE dept IS NULL;

# Note the INNER JOIN misses the teachers with no department and the departments with no teacher.

SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)