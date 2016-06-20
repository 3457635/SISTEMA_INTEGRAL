Public Partial Class NuevoContacto
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub guardar()
        lblMensaje.Text = String.Empty
        Dim primer_nombre As String = StrConv(txbPrimerNombre.Text, VbStrConv.ProperCase)
        Dim segundo_nombre As String = StrConv(txbSegundoNombre.Text, VbStrConv.ProperCase)
        Dim apellido_paterno As String = StrConv(txbApellidoPaterno.Text, VbStrConv.ProperCase)
        Dim apellido_materno As String = StrConv(txbApellidoMaterno.Text, VbStrConv.ProperCase)
        Dim telefono As String = txbTelefonoContacto.Text
        Dim correo As String = txbCorreo.Text
        Dim id_empresa As String = Session("id_empresa")
        If String.IsNullOrEmpty(id_empresa) Then
            id_empresa = ddlEmpresa.SelectedValue
        End If
        Dim radio As String = txbRadio.Text

        If String.IsNullOrEmpty(txbIdContacto.Text) Then
            If apellido_paterno <> "" Then
                Dim strSQL As String = "INSERT INTO personas (primer_nombre,segundo_nombre,apellido_paterno,apellido_materno,id_status) VALUES ('" + primer_nombre + "','" + segundo_nombre + "','" + apellido_paterno + "','" + apellido_materno + "',5);"
                InsertarActualizarRegistro(strSQL)
                Dim id_persona As String = ObtenerLlave("personas")

                Dim query As String = "INSERT INTO contactos (correo,id_empresa,id_persona) VALUES ('" + correo + "'," + id_empresa + "," + id_persona + ")"
                InsertarActualizarRegistro(query)

                If telefono <> "" Then
                    query = "INSERT INTO comunicacion (numero,tipo_comunicacion,id_persona) VALUES ('" + telefono + "',1," + id_persona + ")"
                    InsertarActualizarRegistro(query)
                End If
                If radio <> "" Then
                    query = "INSERT INTO comunicacion (numero,tipo_comunicacion,id_persona) VALUES ('" + radio + "',2," + id_persona + ")"
                    InsertarActualizarRegistro(query)
                End If
                lblMensaje.Text = "Se guardó la información exitosamente."
            Else
                lblContacto.Text = "El campo APELLIDO PATERNO es obligatorio"
            End If
        Else
            Dim buscar_contacto = (From consulta In db.contactos
                                Where consulta.id_contacto = txbIdContacto.Text
                                Select consulta).FirstOrDefault()
            If Not buscar_contacto Is Nothing Then
                buscar_contacto.persona.primer_nombre = txbPrimerNombre.Text
                buscar_contacto.persona.segundo_nombre = txbSegundoNombre.Text
                buscar_contacto.persona.apellido_paterno = txbApellidoPaterno.Text
                buscar_contacto.persona.apellido_materno = txbApellidoMaterno.Text
                buscar_contacto.correo = txbCorreo.Text
                db.SubmitChanges()
                lblMensaje.Text = "Se guardó la información correctamente."
            End If
        End If


    End Sub
    Protected Sub btnGuardarContacto_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarContacto.Click
        guardar()

    End Sub

    
   

   

    Protected Sub btnEliminar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnEliminar.Click
        lblMensaje.Text = String.Empty
        If Not String.IsNullOrEmpty(txbIdContacto.Text) Then
            Dim buscar_contacto = (From consulta In db.contactos
                                Where consulta.id_contacto = ddlAdminContacto.SelectedValue
                                Select consulta).FirstOrDefault()
            If Not buscar_contacto Is Nothing Then
                buscar_contacto.persona.id_status = 6
                db.SubmitChanges()
            End If
        Else
            lblMensaje.Text = "Seleccione el contacto."
        End If
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        lblMensaje.Text = String.Empty
        guardar()

    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        txbApellidoMaterno.Text = String.Empty
        txbApellidoPaterno.Text = String.Empty
        txbPrimerNombre.Text = String.Empty
        txbSegundoNombre.Text = String.Empty
        txbCorreo.Text = String.Empty
        txbIdContacto.Text = String.Empty
        txbTelefonoContacto.Text = String.Empty
        txbRadio.Text = String.Empty

    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        lblMensaje.Text = String.Empty
        Dim buscar_contacto = (From consulta In db.contactos
                            Where consulta.id_contacto = ddlAdminContacto.SelectedValue
                            Select consulta).FirstOrDefault()
        If Not buscar_contacto Is Nothing Then
            txbPrimerNombre.Text = buscar_contacto.persona.primer_nombre
            txbSegundoNombre.Text = buscar_contacto.persona.segundo_nombre
            txbApellidoPaterno.Text = buscar_contacto.persona.apellido_paterno
            txbApellidoMaterno.Text = buscar_contacto.persona.apellido_materno
            txbCorreo.Text = buscar_contacto.correo
        End If
        txbIdContacto.Text = ddlAdminContacto.SelectedValue
    End Sub
End Class