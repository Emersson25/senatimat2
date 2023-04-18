<?php

require_once '../models/Colaboradores.php';

if (isset($_POST['operacion'])){

  $colaboradores = new Colaboradores();

  if ($_POST['operacion'] == 'registrar'){

    //PASO 1: Recolectar todos los valores enviados
    //por la vista y almacenarlos en un array asociativo
    $datosGuardar = [
      "apellidos"       => $_POST['apellidos'],
      "nombres"         => $_POST['nombres'],
      "telefono"        => $_POST['telefono'],
      "tipocontrato"    => $_POST['tipocontrato'],
      "direccion"        => $_POST['direccion'],
      "idcargo"        => $_POST['idcargo'],
      "idsede"           => $_POST['idsede'],
      "cv"              => ''
    ];

     //Vamos a verificar si la vista nos envió una FOTOGRAFIA
     if (isset($_FILES['cv'])){

      $rutaDestino = '../views/document/pdf'; //Carpeta
      $fechaActual = date('c'); //C = Complete, AÑO/MES/DIA/HORA/MINUTO/SEGUNDO
      $nombreArchivo = sha1($fechaActual) . ".pdf";
      $rutaDestino .= $nombreArchivo;

      //Guardamos la fotografía en el servidor
      if (move_uploaded_file($_FILES['cv']['tmp_name'], $rutaDestino)){
        $datosGuardar['cv'] = $nombreArchivo;
      }

    }

    //PASO 2: Enviar el array al método registrar
    $colaboradores->registrarColaboradores($datosGuardar);

  }

  if ($_POST['operacion'] == 'listar'){
    $data = $colaboradores->listarColaboradores();

    if ($data){
      $numeroFila = 1;
      $datosColaborador = '';
      $botonNulo = " <a href='#' class='btn btn-sm btn-warning' title='No hay ningun documento CV'><i class='bi bi-archive'></i></a>";
      
      foreach($data as $registro){
        $datosColaborador = $registro['apellidos'] . ' ' . $registro['nombres'];

        //La primera parte a RENDERIZAR, es lo standard (siempre se muestra)
        echo "
          <tr>
            <td>{$numeroFila}</td>
            <td>{$registro['apellidos']}</td>
            <td>{$registro['nombres']}</td>
            <td>{$registro['telefono']}</td>
            <td>{$registro['tipocontrato']}</td>
            <td>{$registro['cargo']}</td>
            <td>{$registro['direccion']}</td>
            <td>
              <a href='#' target= 'black'  class='btn btn-sm btn-danger'><i class='bi bi-trash3'></i></a>
              <a href='#' target= '_black'  class='btn btn-sm btn-info'><i class='bi bi-pencil-fill'></i></a>";
        
        //La segunda parte a RENDERIZAR, es el botón VER FOTOGRAFÍA
        if ($registro['cv'] == ''){
          echo $botonNulo;
        }else{
          echo " <a href='../views/document/pdf{$registro['cv']}' data-lightbox='{$registro['idcolaborador']}' data-title='{$datosColaborador}' class='btn btn-sm btn-warning'><i class='bi bi-archive'></i></a>";
        }

        //La tercera parte a RENDERIZAR, cierre de la fila
        echo "
            </td>
          </tr>
        ";

        $numeroFila++;
      }
    }
  } //Fin operacion=listar
  

}