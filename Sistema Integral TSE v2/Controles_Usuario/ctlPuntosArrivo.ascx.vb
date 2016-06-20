Public Class ctlPuntosArrivo
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack Then
           
            Session("arrivos") = 1
       
        End If
    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        lblMensaje.Text = ""
        limpiar_formulario()

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        If Not String.IsNullOrEmpty(txbPunto.Text) And ddlUbicacion.SelectedValue <> 0 Then
            If String.IsNullOrEmpty(txbIdPunto.Text) Then

                Dim buscarPunto = (From consulta In db.detalle_arrivos
                                Where consulta.nombre = txbPunto.Text And
                                consulta.id_empresa = ddlCliente.SelectedValue
                                Select consulta).FirstOrDefault()

                If buscarPunto Is Nothing Then

                    Dim nuevo_punto As New detalle_arrivo With {.nombre = txbPunto.Text,
                                                                                .id_ubicacion = ddlUbicacion.SelectedValue,
                                                                                .id_status = 5,
                                                                                .id_empresa = ddlCliente.SelectedValue}
                    db.detalle_arrivos.InsertOnSubmit(nuevo_punto)
                    db.SubmitChanges()
                    lblMensaje.Text = "Se guardo el punto de arrivo."

                Else
                    lblMensaje.Text = "El punto de arribo ya existe."
                End If

            Else
                Dim buscar_punto = (From consulta In db.detalle_arrivos
                                 Where consulta.id_detalle = txbIdPunto.Text
                                 Select consulta).FirstOrDefault()
                If Not buscar_punto Is Nothing Then
                    buscar_punto.nombre = txbPunto.Text
                    buscar_punto.id_ubicacion = ddlUbicacion.SelectedValue
                    db.SubmitChanges()
                    lblMensaje.Text = "Se guardo el punto de arrivo."

                End If
            End If

            limpiar_formulario()
            ddlPunto.DataBind()

            Session("arrivos") = 1
            cargar_lista()
        Else
            lblMensaje.Text = "No ingresó el nombre del punto de arrivo o no ha seleccionado la ubicación."

        End If

    End Sub
    Protected Sub limpiar_formulario()
        txbIdPunto.Text = String.Empty
        txbPunto.Text = String.Empty
        ddlCliente.SelectedValue = 0
        ddlUbicacion.SelectedValue = 0
        ddlPunto.SelectedValue = 0
    End Sub

    Protected Sub btnBorrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBorrar.Click
        If ddlPunto.SelectedValue <> 0 Then
            Dim buscar_punto = (From consulta In db.detalle_arrivos
                              Where consulta.id_detalle = ddlPunto.SelectedValue
                              Select consulta).FirstOrDefault()
            If Not buscar_punto Is Nothing Then
                buscar_punto.id_status = 6
                db.SubmitChanges()
                lblMensaje.Text = "Se borró el punto de arrivo."
                txbPunto.Text = String.Empty
                ddlPunto.SelectedValue = 0
            End If
        End If
        cargar_lista()
    End Sub

    Protected Sub ddlPunto_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlPunto.SelectedIndexChanged
        lblMensaje.Text = ""


        Dim buscar_ubicacion = (From consulta In db.detalle_arrivos
                             Where consulta.id_detalle = ddlPunto.SelectedValue And
                             consulta.id_status = 5
                             Select consulta).FirstOrDefault()

        If Not buscar_ubicacion Is Nothing Then
            ddlUbicacion.SelectedValue = buscar_ubicacion.id_ubicacion
            txbPunto.Text = buscar_ubicacion.nombre
            txbIdPunto.Text = buscar_ubicacion.id_detalle
        End If

        

    End Sub

    

    Protected Sub ddlCliente_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCliente.DataBound
        ddlCliente.Items.Add(New ListItem("Seleccionar...", 0))
        ddlCliente.SelectedValue = 0

    End Sub

    Protected Sub ddlUbicacion_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlUbicacion.DataBound
        ddlUbicacion.Items.Add(New ListItem("Seleccionar...", 0))
        ddlUbicacion.SelectedValue = 0
    End Sub

  
  
    Protected Sub ddlCliente_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCliente.SelectedIndexChanged
        ddlPunto.Items.Clear()
        cargar_lista()
    End Sub

    Protected Sub cargar_lista()
        ddlPunto.Items.Clear()

        Dim mostrar_puntos = From consulta In db.detalle_arrivos
                                                Where consulta.id_empresa = ddlCliente.SelectedValue And
                                                consulta.id_status = 5
                                                Select consulta

        For Each ubicacion In mostrar_puntos
            ddlPunto.Items.Add(New ListItem(ubicacion.nombre, ubicacion.id_detalle))
        Next
        ddlPunto.Items.Add(New ListItem("Seleccionar...", 0))
        ddlPunto.SelectedValue = 0
    End Sub
    
End Class