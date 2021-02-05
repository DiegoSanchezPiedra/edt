let $submarinos := (doc("submaris.xml")/submarinos[submarino/bando="URSS"])
return
<html>
    <head>
        <link href="estil_SOLUCIO.css" rel="stylesheet" type="text/css"></link>
    </head>
    <body>
        <table align="center">
            <tr>
                <th style="text-align: center;">{data($submarinos/titulo)}</th>
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
               
               <a href="submarino/pag_webpag_web/{data($submarino/pag_web)}">{data($submarino/nombre)}</a>
               </td>
               
               <td align="right">
                 {data($submarino/caracteristicas_generales/propulsion)} de {data($submarino/caracteristicas_generales/potencia_watios)} ({data($submarino/caracteristicas_generales/potencia_caballos)})
                 </td>
                 <td align="right">
                {
                for $torpedo in $submarino/armamento/armas/torpedos/torpedo_identificador
                return
                (data($torpedo/nombre/@cantidad),'del tipus',data($torpedo/nombre),<br/>)
              }   
              </td>   
              <td align="right">
              {
                for $misil in $submarino/armamento/armas/misiles/misil_identificador
                return
                (data($misil/nombre/@cantidad),'del tipus',data($misil/nombre),<br/>)
              }
              </td>  
             </tr>
           }      
           <tr>
           <td colspan="2" align="left">
           <p><b>Unitats totals plantejades:</b>{sum($submarinos/submarino/unidades_planeadas)}</p>
           </td>
           <td colspan="2" align="right">
           <p><b>Unitats totals construides:</b>{sum($submarinos/submarino/unidades_construidas)}</p>
           </td>
           </tr>       
        </table>
    </body>
</html>