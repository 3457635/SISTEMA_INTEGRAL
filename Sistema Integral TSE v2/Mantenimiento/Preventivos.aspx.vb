Public Class Preventivos
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbFecha.Text = Now.AddHours(-7).ToString("dd/MM/yyyy")
        Else
            If Session("Tipo_Servicio") = 1 Then
                cargar_modal()
            End If

        End If
    End Sub

    Protected Sub DropDownList2_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlUnidad.DataBound

        Dim seleccionar As ListItem
        seleccionar = New ListItem("Seleccionar...", 0)
        seleccionar.Selected = True
        ddlUnidad.Items.Add(seleccionar)

    End Sub

 

    Protected Sub DropDownList1_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList1.DataBound

        Dim seleccionar As ListItem
        seleccionar = New ListItem("Seleccionar...", 0)
        seleccionar.Selected = True
        DropDownList1.Items.Add(seleccionar)
    End Sub

    Protected Sub btnGuadar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuadar.Click

        If ddlUnidad.SelectedValue <> 0 Then
            If txbComentarios.Text.Length < 500 Then
                Dim id_equipo = ddlUnidad.SelectedValue
                Dim id_reparacion = ddlTipoReparacion.SelectedValue
                Dim distancia = txbOdometro.Text

                Dim nueva_reparacion As New reparacione With {.fecha = txbFecha.Text,
                                                                                 .lugar = txbLugar.Text,
                                                                                 .odometro = txbOdometro.Text,
                                                                                 .tipo_reparacion = id_reparacion,
                                                                                 .comentarios = txbComentarios.Text,
                                                              .costo = txbCosto.Text}

                Dim nuevo_preventivo As New preventivo With {.id_equipo = id_equipo,
                                                             .reparacione = nueva_reparacion,
                                                             .proximoServicio = txbSiguienteServicio.Text}


                db.preventivos.InsertOnSubmit(nuevo_preventivo)
                db.SubmitChanges()

                lblMensaje.Text = "La información se guardó exitosamente."
                GridView1.DataBind()

                Dim programacion_servicio = buscar_programacion_servicio(id_equipo, id_reparacion)
                If programacion_servicio <> 0 Then

                    Dim siguiente_servicio = buscar_siguiente_servicio(id_equipo, id_reparacion, programacion_servicio)


                End If

            Else
                lblMensaje.Text = "El campo de comentarios excede el tamaño permitido."
            End If


        Else
            lblMensaje.Text = "Seleccione la Unidad."
        End If

    End Sub

    Protected Sub lnkAgregar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkAgregar.Click
        cargar_modal()

    End Sub
    Protected Sub cargar_modal()
        PlaceHolder1.Controls.Clear()
        Session("Correctivo") = False
        Dim nuevo_control As UserControl = LoadControl("~/controles_usuario/ctlPreventivos.ascx")
        PlaceHolder1.Controls.Add(nuevo_control)
        mdlPopup.Show()
    End Sub
    Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click
        Session("Tipo_Servicio") = 0
        PlaceHolder1.Controls.Clear()

        mdlPopup.Hide()
        ddlTipoReparacion.DataBind()
    End Sub

    Protected Sub ddlUnidad_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlUnidad.SelectedIndexChanged
        txbComentarios.Text = String.Empty
        txbOdometro.Text = String.Empty

    End Sub

   

    Public Function buscar_siguiente_servicio(ByVal id_equipo As Integer, ByVal id_reparacion As Integer, ByVal programacion_servicio As Integer)
        Dim buscar_ultimo_servicio = (From consulta In db.reparaciones
                                   Where
                                   consulta.tipo_reparacion = id_reparacion
                                   Select consulta Order By consulta.odometro Descending).FirstOrDefault()
        Dim siguiente_servicio As Integer = 0
        If Not buscar_ultimo_servicio Is Nothing Then
            siguiente_servicio = programacion_servicio + buscar_ultimo_servicio.odometro
        End If
        Return siguiente_servicio
    End Function

    Protected Sub ddlTipoReparacion_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlTipoReparacion.DataBound
        Dim seleccionar As ListItem
        seleccionar = New ListItem("Seleccionar...", 0)
        seleccionar.Selected = True
        ddlTipoReparacion.Items.Add(seleccionar)

    End Sub

    

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList1.SelectedIndexChanged

    End Sub

    Protected Sub ddlTipoReparacion_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlTipoReparacion.SelectedIndexChanged
        Dim id_equipo = ddlUnidad.SelectedValue
        Dim id_reparacion = ddlTipoReparacion.SelectedValue

        Dim distancia = buscar_programacion_servicio(ddlUnidad.SelectedValue, ddlTipoReparacion.SelectedValue)

        'If distancia = 0 Then
        '    lblDistancia.Text = "No ha programado este servicio."
        'Else
        '    lblDistancia.Text = "Este servicio se realiza cada " + distancia.ToString()
        'End If
    End Sub

    
End Class