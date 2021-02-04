let $submarinos := (doc("submaris.xml")/submarinos)
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
                <td><img id="esquinarImagen" src="banderes/{$submarinos/logo}"></img></td>
            </tr>
        </table>
        <table id="t01" border="1" align="center">
            <tr>
              <th style="background-color: red;">nom</th>
              <th style="background-color: red;">propulsió</th>
              <th style="background-color: red;">Torpedes</th>
              <th style="background-color: red;">Missils</th>
            </tr>
            
              {
               for $submarino in $submarinos/submarino
               return 
               <tr>
               <td>
               <img width="256px" id="esquinarImagen,responsive-image" src="imatges/{data($submarino/imatges/foto)}">
               </img>
               <a href="submarino/pag_webpag_web/{data($submarino/pag_web)}" alt="submarino/$submarino/@nom"></a>
               </td>
               </tr>
              }
        </table>
    </body>
</html>