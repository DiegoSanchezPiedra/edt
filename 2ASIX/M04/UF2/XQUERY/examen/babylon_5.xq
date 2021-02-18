let $baby := doc("Babylon_5.xml")/babylon5
return
<html>
  <head>
  <title>Babylon_5</title>
    <link href="estil_SOLUCIO.css" rel="stylesheet" type="text/css"/>
  </head>
  <body>
    <table align="center" width="900px">
      <tr>
        <td>
          <a href="{$baby/dades_generals/web}"><img id="esquinarImagen" src="imatges_logos/logos/{$baby/dades_generals/logo}" alt="{$baby/dades_generals/titol}" width="100%" height="auto"></img></a>
        </td>
      </tr>
    </table>
    <table id="t01" align="center" border="1" width="900px">
      <tr>
        <th colspan="4">
          Nº de noms de naus = {
            count($baby/nau/noms/nom)
          }<br></br>
          Nº de noms de naus coneguts = {
            sum($baby/nau/noms/@coneguts)
          }<br></br>
          Nº de noms de naus coneguts dorigen Earth_Alliance = {
            sum($baby/nau[origen='Earth_Alliance']/noms/@coneguts)
          }<br></br>
          Nº de noms de naus coneguts dorigen Narn = {
            sum($baby/nau[origen='Narn']/noms/@coneguts)
          }
        </th>
      </tr>
      <tr>
        <th width="320px">
          Nom
        </th>
        <th width="120px">
          Bandol
        </th>
        <th width="320">
          Caracteristiques
        </th>
        <th width="140px">
          Noms coneguts
        </th>
      </tr>
      {
        for $nau in $baby/nau
        order by $nau/origen
        return
        <tr>
          <td class="normal centrado">
            <img width="100%" height="auto" src="imatges_logos/imatges/{$nau/imatge}" alt="{$nau/classe/@classe}"></img><br></br>
            <a href="{$nau/pag_web}">{data($nau/classe/@classe)}</a>
          </td>
          <td class="normal">
            <img width="100px" src="imatges_logos/logos/{$nau/logo}"></img>
          </td>
          <td class="normal">
            Tonelatge: {data($nau/caracteristiques/tonelatge)} de {data($nau/caracteristiques/tonelatge/@unitat)}<br></br>
            Longitud: {(data($nau/caracteristiques/longitud),data($nau/caracteristiques/longitud/@unitat))}<br></br>
            Tripulacio: {data($nau/capacitat_humana/tripulacio)}<br></br>
            Naus transpotades:
            <ul style="list-style: none;">
              <li>
                caces: {data($nau/capacitat_naus/caces)}
              </li>
              <li>
                Transport de tropes: {data($nau/capacitat_naus/transports_tropes)}
              </li>
            </ul>
            Abast: {(data($nau/abast/quantitat),data($nau/abast/unitat_de_mesura))}<br></br>
            Propulsio:
            <ul style="list-style: none;">
              <li>
                Reactor: {(data($nau/propulsio/reactors/@numero),'de',data($nau/propulsio/reactors))}
              </li>
              <li>
                Motors d impulsio: {(data($nau/propulsio/numero_de_motors_impulsio),'de',data($nau/propulsio/motors_impulsio))}
              </li>
              <li>
                Potencia Standard: {(data($nau/propulsio/potencia_standart),data($nau/propulsio/unitat_de_mesura_potencia))}
              </li>
              <li>
                Potencia militar: {(data($nau/propulsio/potencia_militar),data($nau/propulsio/unitat_de_mesura_potencia))}
              </li>
            </ul>
          </td>
          <td class="normal">
            {
              for $nom in $nau/noms/nom
              return
              (data($nom),<br/>)
            }
            <br></br>
            (Nº noms= {count($nau/noms/nom)})
          </td>
        </tr>
      }
    </table>
  </body>
</html>