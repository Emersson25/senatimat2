<?php

require_once 'Conexion.php';

class Colaboradores extends Conexion{

  private $accesoBD;

  public function __CONSTRUCT(){
    $this->accesoBD = parent::getConexion();
  }

  //Datos[] es un array asociativo, que contiene la información
  //a guardar proveniente del controlador
  public function registrarColaboradores($datos = []){
    try{
      $consulta = $this->accesoBD->prepare("CALL spu_colaboradores_registrar(?,?,?,?,?,?,?,?)");
      $consulta->execute(
        array(
          $datos['apellidos'], 
          $datos['nombres'], 
          $datos['telefono'],
          $datos['tipocontrato'],
          $datos['direccion'],
          $datos['idcargo'],
          $datos['idsede'],
          $datos['cv']
        )
      );
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }

  public function listarColaboradores(){
    try{
      $consulta = $this->accesoBD->prepare("CALL spu_colaboradores_listar()");
      $consulta->execute();

      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }
}