<html>
<body>
<h1>Llistat de llibres</h1>
<table border="1">
<tr>
<th>Titulo</th>
<th>Editorial</th>
<th>Precio</th>
</tr>
{
  for $libro in doc('biblio.xml')/bib/libro
  return
  <tr style="border: 1px solid black">
  <td style="text-align:left"><b>{data($libro/titulo)}</b></td>
  <td style="text-align:left"><b>{data($libro/editorial)}</b></td>
  <td style="text-align:right"><b>{data($libro/precio)}</b></td>
  </tr>
}
</table>
</body>
</html>