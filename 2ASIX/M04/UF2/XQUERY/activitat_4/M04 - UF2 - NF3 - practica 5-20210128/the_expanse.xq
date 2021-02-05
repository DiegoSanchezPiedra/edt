let $dades:=(doc("The_Expanse.xml")/the_expanse/dades)
let $MCRP:=(doc("The_Expanse.xml")/the_expanse/Martian_Congressional_Republic_Navy)
return
<html>
  <head>
    <link href="M04 - UF2 - NF3 - practica 5/css/estil_SOLUCIO.css" rel="stylesheet" type="text/css"></link>
  </head>
  <body>
    <table align="center">
      <tr>
        <td>
          <img src="M04 - UF2 - NF3 - practica 5/logos/{$dades/logo}" alt="{$dades/titol}"></img>
        </td>
      </tr>
    </table>
    <table id="t01" border="1" align="center">
      <tr>
        <th width="320px">
          Nom
        </th>
        <th width="120px">
          Bandol
        </th>
        <th width="400">
          Característiques
        </th>
        <th width="240px">
          Noms Coneguts
        </th>
      </tr>
      {
        for $nau in $MCRP/nau
        return 
        <tr>
          <td align="center" class="normal">
            <img width="320px" src="M04 - UF2 - NF3 - practica 5/imatges/{$nau/imatge}"></img><br></br>
            <a href="{$nau/web}">{$nau/classe}</a>
          </td>
          <td class="normal">
            <img width="220px" src="M04 - UF2 - NF3 - practica 5/logos/{$nau/logo}"></img>
          </td>  
          <td class="normal">
            tipus de nau: {data($nau/tipus)}<br></br>
            
            tonelatge: {(data($nau/caracteristiques/tonelatge),"de",data($nau/caracteristiques/tonelatge/@unitat))}<br></br>
            
            Longitud: {(data($nau/caracteristiques/longitud),data($nau/caracteristiques/longitud/@unitat))}<br></br>
            
            Tripulació: {data($nau/capacitat_humana/tripulacio)}<br></br>
            
            <b>Tropes: {(data($nau/capacitat_humana/tropes/@quantitat),"de",data($nau/capacitat_humana/tropes))}</b><br></br>
            
            Propulsió: {(data($nau/propulsio/numero_de_motors_impulsio),data($nau/propulsio/motors_impulsio))}
          </td>
          <td>
          {
            for $nom in $nau/designacions/nom
            return
            (<p>{data($nom)}</p>)
          }
          (nº de noms= {count($nau/designacions/nom)})
          </td>
        </tr>
      }
    </table>
  </body>
</html>