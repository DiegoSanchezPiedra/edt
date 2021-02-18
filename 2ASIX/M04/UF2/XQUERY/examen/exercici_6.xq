let $collection := doc("cine.xml")/collection

return 
<html>
  <body>
    <table border="1" align="center">
      <tr>
        <td>
          TITOL
        </td>
        <td>
          ANY
        </td>
      </tr>
      {
        for $peli in $collection/movie
        order by $peli/year
        where contains($peli/type,'Science Fiction')
        return
        <tr>
          <td>
            {data($peli/@title)}
          </td>
          <td>
            {data($peli/year)}
          </td>
        </tr>
      }
      <tr>
        <td align="right">
          Total de pelis
        </td>
        <td align="center">
          {
            let $peli := $collection/movie[contains(type,'Science Fiction')]
            return
            count($peli)
          }
        </td>
      </tr>
    </table>
  </body>
</html>
