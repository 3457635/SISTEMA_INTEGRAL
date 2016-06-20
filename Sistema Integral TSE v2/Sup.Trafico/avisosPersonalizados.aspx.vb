Public Class avisosPersonalizados
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ddlRuta_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlRuta.SelectedIndexChanged

        Dim ubicaciones As New DataTable
        ubicaciones.TableName = "ubica"
        ubicaciones.Columns.Add("ubicacion", GetType(String))
        ubicaciones.Columns.Add("id_ubicacion", GetType(String))

        Dim llegamos_ultima_parada As Boolean = False

        Dim idRuta As Integer = ddlRuta.SelectedValue
        Dim id_principal As String = id_principal_origen(idRuta) 'obtenemos la llave del punto de origen
        Dim id_destino As String = siguiente_parada(CInt(id_principal), idRuta)
        Dim id_origen As String = id_ubicacion_origen(idRuta) 'obtenemos la llave de la ubicación
        Dim posicion_actual As String = id_origen
        Dim destino_original As Integer = 0
        Dim ruta_con_vuelta As Boolean = False
        Dim id_principal_siguiente As Integer = 0
        Dim botador As Integer = 0

        Dim idEmpresa = ddlEmpresa.SelectedValue

        While Not llegamos_ultima_parada

            Dim punto_interseccion As String = obtener_puntodeinterseccion(posicion_actual, id_destino)

            If punto_interseccion <> id_destino Then
                destino_original = id_destino
                id_destino = encontrar_punto_max_subruta(punto_interseccion)
                ruta_con_vuelta = True
            Else
                ruta_con_vuelta = False
            End If
            id_principal_siguiente += 1

            Dim tipo_ubicacion As String = ""
            Dim ir_a As String = ""

            Dim query As String = String.Empty

            While posicion_actual <> id_destino And botador < 45

                tipo_ubicacion = obtener_tipo_ubicacion(posicion_actual)
                botador += 1
                If botador <> 1 Then
                    ir_a = obtener_siguiente_paso(id_destino, posicion_actual, tipo_ubicacion)
                    posicion_actual = ir_a
                End If

                Dim nombre_ubicacion As String = obtener_nombre_ubicacion(posicion_actual)

                Dim buscar_id_principal = (From consulta In db.ubicaciones
                           Where consulta.id_ubicacion = posicion_actual
                           Select consulta).FirstOrDefault()

                Dim id_principal_ubicacion = buscar_id_principal.id_principal

                ubicaciones.Rows.Add(nombre_ubicacion, id_principal_ubicacion)

            End While

            If botador >= 60 Then
                llegamos_ultima_parada = True
            Else
                If ruta_con_vuelta Then
                    posicion_actual = id_destino
                    id_destino = destino_original
                Else
                    posicion_actual = id_destino
                    id_destino = siguiente_parada(CInt(id_principal) + id_principal_siguiente, idRuta)
                    If id_destino = "" Then
                        llegamos_ultima_parada = True
                    End If
                End If
            End If
        End While
        ckbUbicaciones.DataTextField = "ubicacion"
        ckbUbicaciones.DataValueField = "id_ubicacion"


        ckbUbicaciones.DataSource = ubicaciones
        ckbUbicaciones.DataBind()

        
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim idEmpresa = ddlEmpresa.SelectedValue
        Dim RutaId = ddlRuta.SelectedValue

        For i = 0 To ckbUbicaciones.Items.Count - 1 Step 1
            If ckbUbicaciones.Items(i).Selected Then
                Dim idUbicacion = ckbUbicaciones.Items(i).Value

                Dim nuevaPersonalizacion As New notificacionesPersonalizada With {.EmpresaId = idEmpresa,
                                                                                  .UbicacionId = idUbicacion,
                                                                                  .RutaId = RutaId}

                db.notificacionesPersonalizadas.InsertOnSubmit(nuevaPersonalizacion)
                db.SubmitChanges()

            End If

        Next
        GridView2.DataBind()

        

    End Sub

    Protected Sub ckbUbicaciones_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ckbUbicaciones.SelectedIndexChanged

    End Sub
End Class