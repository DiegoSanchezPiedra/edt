let $libros := (doc("biblio.xml")/bib/libro[autor/apellido="Stevens"])
return 
<html>
  <body>
    <h1>Libros de Stevens</h1>
    <table border="1">
      <tr>
        <th>Titulo</th>
        <th>Precio</th>
      </tr>
      {
        for $libro in $libros
        return 
        <tr style="border: 1px solid black">
          <td style="text-align:left">{data($libro/titulo)}</td>
          <td style="text-align:right">{data($libro/precio)}</td>
        </tr>
      }
      <tr>
        <td style="text-align: right"><b>Precio total</b></td>
        <td>{sum($libros/precio)}</td>
      </tr>
     </table>
  </body>
</html>