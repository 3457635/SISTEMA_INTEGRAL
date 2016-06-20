Public Class Programacion_servicios
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        If ddlUnidad.SelectedValue <> 0 Then
            Dim id_equipo = ddlUnidad.SelectedValue
            Dim id_reparacion = ddlReparacion.SelectedValue
            Dim distacia = txbDistancia.Text

            Dim buscar_programacion = (From consulta In db.programacion_servicios
                                    Where consulta.id_equipo = id_equipo And
                                    consulta.id_reparacion = id_equipo And
                                    consulta.distancia = distacia
                                    Select consulta).FirstOrDefault()

            If buscar_programacion Is Nothing Then
                Dim nuevo_servicio As New programacion_servicio With {.id_equipo = ddlUnidad.SelectedValue,
                                                                                 .id_reparacion = ddlReparacion.SelectedValue,
                                                                                 .distancia = txbDistancia.Text
                                                                                }
                db.programacion_servicios.InsertOnSubmit(nuevo_servicio)
            Else
                buscar_programacion.id_equipo = id_equipo
                buscar_programacion.id_reparacion = id_reparacion
                buscar_programacion.distancia = distacia

            End If
            db.SubmitChanges()
            lblMensaje.Text = "Se guardó la información exitosamente."
        End If

    End Sub

    Protected Sub ddlReparacion_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlReparacion.DataBound
        Dim nuevo_item As ListItem = New ListItem("Seleccionar...", 0)
        nuevo_item.Selected = True
        ddlReparacion.Items.Add(nuevo_item)
    End Sub

    

    Protected Sub ddlTipoEquipo_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlTipoEquipo.SelectedIndexChanged

    End Sub

    Protected Sub ddlUnidad_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlUnidad.DataBound
        Dim nuevo_item As ListItem = New ListItem("Seleccionar...", 0)
        nuevo_item.Selected = True
        ddlUnidad.Items.Add(nuevo_item)
    End Sub

    Protected Sub ddlTipoEquipo_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlTipoEquipo.DataBound
        Dim nuevo_item As ListItem = New ListItem("Seleccionar...", 0)
        nuevo_item.Selected = True
        ddlTipoEquipo.Items.Add(nuevo_item)
    End Sub

    Protected Sub ddlUnidad_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlUnidad.SelectedIndexChanged
        lblMensaje.Text = String.Empty
        Dim id_equipo = ddlUnidad.SelectedValue
        Dim id_reparacion = ddlReparacion.SelectedValue

        Dim programacion = buscar_programacion_servicio(id_equipo, id_reparacion)
        If programacion <> 0 Then
            txbDistancia.Text = programacion
        End If
    End Sub

    Protected Sub ddlReparacion_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlReparacion.SelectedIndexChanged

    End Sub
End Class