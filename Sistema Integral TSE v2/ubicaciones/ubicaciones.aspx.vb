Public Class ubicaciones
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        Dim ubicacion = txbUbicacion.Text
        Dim posicion = txbPosicion.Text
        Dim tiempo = txbTiempo.Text
        Dim tipo_ubicacion = ddlTipoUbicacion.SelectedValue

        If Not String.IsNullOrEmpty(ubicacion) And
            Not String.IsNullOrEmpty(posicion) And
            Not String.IsNullOrEmpty(tiempo) And
            Not String.IsNullOrEmpty(tipo_ubicacion) Then

            Dim nueva_ubicacion As New ubicacione With {.ubicacion = ubicacion,
                                                        .id_ubicacion = posicion,
                                                        .tiempo = tiempo,
                                                        .id_tipo_ubicacion = tipo_ubicacion,
                                                        .id_status = 2,
                                                        .notificacion_cliente = rbtnNotificacion.SelectedValue}

            db.ubicaciones.InsertOnSubmit(nueva_ubicacion)
            db.SubmitChanges()
            GridView1.DataBind()

            lblMensaje.Text = "Se guardó la información."
        Else
            lblMensaje.Text = "Complete todos los campos antes de guardar."
        End If



    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim imgEstatus As Image = CType(e.Row.FindControl("imgEstatus"), Image)
            Dim imgNotificacion As Image = CType(e.Row.FindControl("imgNotificacion"), Image)

            Dim id_principal = e.Row.Cells(1).Text

            Dim buscar_estatus_ubicacion = (From consulta In db.ubicaciones
                                         Where consulta.id_principal = id_principal
                                         Select consulta).FirstOrDefault()

            If Not buscar_estatus_ubicacion Is Nothing Then
                Dim estatus = buscar_estatus_ubicacion.id_status
                Dim notificacion = buscar_estatus_ubicacion.notificacion_cliente

                If estatus = 3 Then
                    imgEstatus.Visible = True
                End If

                If notificacion Then
                    imgNotificacion.Visible = True
                End If

            End If

        End If
    End Sub

  
    
    
End Class