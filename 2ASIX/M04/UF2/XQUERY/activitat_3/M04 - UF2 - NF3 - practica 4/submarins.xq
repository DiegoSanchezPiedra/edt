let $submarinos := (doc("submaris.xml")/submarinos[submarino/bando="URSS"])
return
<html>
    <head>
        <link href="estil_SOLUCIO.css" rel="stylesheet" type="text/css"></link>
    </head>
    <body>
        <table align="center">
            <tr>
                <th style="text-align: center;">{$submarinos/titulo}</th>
            </tr>
            <tr>
                <td>
                <img id="esquinarImagen" src="banderes/{$submarinos/logo}"></img>
                </td>
            </tr>
        </table>
        <table id="t01" border="1" align="center">
            <tr>
              <th>nom</th>
              <th width="410px">propulsió</th>
              <th width="220px">Torpedes</th>
              <th width="250px">Missils</th>
            </tr>            
              {
               for $submarino in $submarinos/submarino
               return 
               <tr>
               
               <td align="center" class="normal">
               <img width="256px" id="esquinarImagen,responsive-image" src="imatges/{data($submarino/imatges/foto)}">
               </img>
               
               <br></br>
               
               <a href="submarino/pag_webpag_web/{data($submarino/pag_web)}">{$submarino/nombre}</a>
               </td>
               
               <td align="right">
                 {$submarino/caracteristicas_generales/propulsion} de {$submarino/caracteristicas_generales/potencia_watios}
                 </td>
                 <td>
                {
                for $torpedo in $submarino/armamento/armas/torpedos/torpedo_identificador
                return
                <p>{data($torpedo/nombre/@cantidad),'del tipus',data($torpedo/nombre)}</p>
              }   
              </td>     
             </tr>
           }             
        </table>
    </body>
</html>