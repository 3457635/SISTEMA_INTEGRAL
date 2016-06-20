Partial Public Class Nuevo_
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardarCliente_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarCliente.Click

        Dim tipo_empresa As Integer = Session("tipo_empresa")
        Dim fecha_alta = Now().AddHours(-7)
        Dim nombre As String = StrConv(txbNombre.Text, VbStrConv.ProperCase)
        Dim frecuente = ckbFrecuente.Checked

        If IsNumeric(tipo_empresa) Then
            Dim db As New DataClasses1DataContext()

            If txbIdEmpresa.Text = "" Then

                Dim buscarRfc = (From consulta In db.empresas
                              Where consulta.nombre = nombre And
                              consulta.id_tipo_empresa = tipo_empresa
                              Select consulta).FirstOrDefault()

                If buscarRfc Is Nothing Then
                    Dim nueva_empresa As New empresa With {.fecha_alta = fecha_alta,
                                                                          .id_status = 5,
                                                                          .id_tipo_empresa = tipo_empresa,
                                                                          .nombre = nombre,
                                                           .frecuente = frecuente
                                                           }

                    db.empresas.InsertOnSubmit(nueva_empresa)
                    db.SubmitChanges()

                    lblGuardarCliente.Text = " Se guardó la empresa " + nombre
                    ddlEmpresa.DataBind()

                    Dim buscarEmpresa = (From consulta In db.empresas
                                      Where consulta.nombre = nombre
                                      Select consulta).FirstOrDefault()

                    If Not buscarEmpresa Is Nothing Then
                        txbIdEmpresa.Text = buscarEmpresa.id_empresa
                    End If

                Else
                    lblGuardarCliente.Text = "La empresa ya existe."
                End If


            Else

                Dim actualizar_empresa = (From consulta In db.empresas
                                         Where consulta.id_empresa = txbIdEmpresa.Text
                                         Select consulta).FirstOrDefault()

                If Not actualizar_empresa Is Nothing Then
                    actualizar_empresa.nombre = nombre
                    actualizar_empresa.frecuente = frecuente
                    db.SubmitChanges()
                End If

                ddlEmpresa.DataBind()
                lblGuardarCliente.Text = "Se actualizó la empresa " + nombre
            End If
        End If
        Session("cerrar") = 1
    End Sub



    Protected Sub ddlEmpresa_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged
        Dim buscarEmpresa = (From consulta In db.empresas
                      Where consulta.id_empresa = ddlEmpresa.SelectedValue
                      Select consulta).FirstOrDefault()

        limpiar_formulario()

        If Not buscarEmpresa Is Nothing Then
            txbNombre.Text = buscarEmpresa.nombre
            txbIdEmpresa.Text = buscarEmpresa.id_empresa
            lblMensaje.Text = String.Empty
            ckbFrecuente.Checked = buscarEmpresa.frecuente
        End If

    End Sub

    Protected Sub btnEliminar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnEliminar.Click
        If txbIdEmpresa.Text <> "" Then
            Dim db As New DataClasses1DataContext()
            Dim eliminar_empresa = (From consulta In db.empresas
                                 Where consulta.id_empresa = txbIdEmpresa.Text
                                 Select consulta).First()

            eliminar_empresa.id_status = 6
            db.SubmitChanges()
            limpiar_formulario()
            lblGuardarCliente.Text = "Se eliminó la empresa " + eliminar_empresa.nombre
        Else
            lblGuardarCliente.Text = "Seleccione la empresa."
        End If
    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        limpiar_formulario()
        ddlEmpresa.DataBind()
        txbNombre.Text = String.Empty
        txbIdEmpresa.Text = ""
        lblGuardarCliente.Text = ""
    End Sub

    Protected Sub limpiar_formulario()
        txbMunicipio.Text = String.Empty
        txbColonia.Text = String.Empty
        txbCP.Text = String.Empty
        txbCalle.Text = String.Empty
        txbEstado.Text = String.Empty
        txbFax.Text = String.Empty
        txbNoExterior.Text = String.Empty
        txbRFC.Text = String.Empty
        txbTelefono.Text = String.Empty
        txbRazon.Text = String.Empty
        ckbRetencion.Checked = False
        txbPais.Text = String.Empty
        lblGuardarCliente.Text = String.Empty
    End Sub

    
    

    Protected Sub ddlEmpresa_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlEmpresa.DataBound
        ddlEmpresa.Items.Insert(0, New ListItem("Seleccionar...", "0"))
    End Sub

    Protected Sub ddlRazonSocial_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlRazonSocial.SelectedIndexChanged

        Dim datoFacturacion = (From consulta In db.datos_facturacions
                     Where consulta.id_dato = ddlRazonSocial.SelectedValue
                     Select consulta).FirstOrDefault()

        If Not datoFacturacion Is Nothing Then
            txbNombre.Text = datoFacturacion.empresa.nombre
            txbMunicipio.Text = datoFacturacion.municipio
            txbColonia.Text = datoFacturacion.colonia
            txbCP.Text = datoFacturacion.c_postal
            txbCalle.Text = datoFacturacion.calle
            txbNoExterior.Text = datoFacturacion.noExterior
            txbPais.Text = datoFacturacion.pais
            txbEstado.Text = datoFacturacion.estado
            txbRazon.Text = datoFacturacion.razon_social
            txbIdDato.Text = datoFacturacion.id_dato
            txbRFC.Text = datoFacturacion.rfc
            ckbRetencion.Checked = datoFacturacion.retencion
            txbTelefono.Text = datoFacturacion.telefono
            txbDiasCredito.Text = datoFacturacion.diasCredito
            lblGuardarCliente.Text = ""
        End If
    End Sub

    Protected Sub ddlRazonSocial_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlRazonSocial.DataBound
        ddlRazonSocial.Items.Add(Crear_item("Seleccionar..", 0))

    End Sub

    Protected Sub btnGuardarDato_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarDato.Click


        Dim fecha_alta As DateTime = DateTime.Now.AddHours(-7)
        Dim f_alta As String = fecha_alta.ToString("dd/MM/yyyy")

        Dim razon_social As String = StrConv(txbRazon.Text, VbStrConv.Uppercase)

        Dim calle As String = StrConv(txbCalle.Text, VbStrConv.Uppercase)
        Dim colonia As String = StrConv(txbColonia.Text, VbStrConv.Uppercase)
        Dim municipio As String = StrConv(txbMunicipio.Text, VbStrConv.Uppercase)
        Dim estado As String = StrConv(txbEstado.Text, VbStrConv.Uppercase)
        Dim pais As String = StrConv(txbPais.Text, VbStrConv.Uppercase)
        Dim noExterior As String = StrConv(txbNoExterior.Text, VbStrConv.Uppercase)
        Dim cp As String = txbCP.Text
        Dim telefono As String = txbTelefono.Text
        Dim fax As String = txbFax.Text
        Dim rfc As String = txbRFC.Text
        Dim tc As Decimal = 0

        Dim idEmpresa As Integer = txbIdEmpresa.Text

        If IsNumeric(txbTC.Text) Then
            tc = CDec(txbTC.Text)
        Else
            tc = 0
        End If

        
        If Not String.IsNullOrEmpty(txbIdEmpresa.Text) Then
            If txbIdDato.Text = "" Then

                Dim buscarRfc = (From consulta In db.datos_facturacions
                              Where consulta.rfc = rfc And
                              consulta.id_empresa = idEmpresa
                              Select consulta).FirstOrDefault()

                If buscarRfc Is Nothing Then

                    Dim datos_facturacion As New datos_facturacion With {
                        .razon_social = razon_social,
                        .id_empresa = idEmpresa,
                        .calle = calle,
                        .colonia = colonia,
                        .pais = pais,
                        .noExterior = noExterior,
                        .municipio = municipio,
                        .estado = estado,
                        .c_postal = cp,
                        .telefono = telefono,
                        .rfc = rfc,
                        .retencion = ckbRetencion.Checked,
                        .tipo_cambio = tc,
                        .diasCredito = txbDiasCredito.Text,
                        .idEstatus = 5}


                    db.datos_facturacions.InsertOnSubmit(datos_facturacion)
                    db.SubmitChanges()
                    lblGuardarCliente.Text = " Se guardarón los datos de facturación."
                    ddlRazonSocial.DataBind()
                Else
                    lblGuardarCliente.Text = "Los datos de facturación ya existen."
                End If


            Else

                Dim actualizar_empresa = (From consulta In db.datos_facturacions
                                         Where consulta.id_dato = txbIdDato.Text
                                         Select consulta).FirstOrDefault()
                If Not actualizar_empresa Is Nothing Then
                    actualizar_empresa.municipio = municipio
                    actualizar_empresa.estado = estado
                    actualizar_empresa.pais = pais
                    actualizar_empresa.c_postal = cp
                    actualizar_empresa.colonia = colonia
                    actualizar_empresa.calle = calle
                    actualizar_empresa.noExterior = noExterior
                    actualizar_empresa.razon_social = razon_social
                    actualizar_empresa.rfc = rfc
                    actualizar_empresa.telefono = telefono
                    actualizar_empresa.tipo_cambio = tc
                    actualizar_empresa.retencion = ckbRetencion.Checked
                    actualizar_empresa.diasCredito = txbDiasCredito.Text
                    db.SubmitChanges()
                    ddlRazonSocial.DataBind()
                    lblGuardarCliente.Text = "Se actualizarón los datos de facturación. "
                Else
                    lblGuardarCliente.Text = "Ocurrió un problema al guardar."
                End If

            End If
        End If


        Session("cerrar") = 1
    End Sub

    Protected Sub btnNuevoDato_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevoDato.Click
        limpiar_formulario()
    End Sub

    Protected Sub btnEliminarDato_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnEliminarDato.Click
        Dim buscarDatos = (From consulta In db.datos_facturacions
                        Where consulta.id_dato = ddlRazonSocial.SelectedValue
                        Select consulta).FirstOrDefault()

        If Not buscarDatos Is Nothing Then
            buscarDatos.idEstatus = 6
            db.SubmitChanges()
            lblMensaje.Text = "Se eliminó el cliente correctamente."
        End If

    End Sub
End Class