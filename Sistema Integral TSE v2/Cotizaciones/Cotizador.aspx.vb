Public Class Cotizador
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim modificar As Boolean = False
    Dim proxy As New wcfRef1.Service1Client()


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            actualizar_configuracion()
            Dim id_cotizacion = Request("id_cotizacion")

            If Not String.IsNullOrEmpty(id_cotizacion) Then
                txbIdCotizacion.Text = id_cotizacion
                Dim buscar_cotizacion = (From consulta In db.cotizaciones
                                      Where consulta.id_cotizacion = id_cotizacion
                                      Select consulta).FirstOrDefault()

                If Not buscar_cotizacion Is Nothing Then
                    lblAno.Text = buscar_cotizacion.ano
                    lblConsecutivo.Text = buscar_cotizacion.consecutivo

                    Dim buscarEmpresa = (From consulta In db.precios
                                      Where consulta.id_cotizacion = id_cotizacion
                                      Select consulta.id_empresa).FirstOrDefault()
                    If Not buscarEmpresa Is Nothing Then
                        ddlEmpresa.SelectedValue = buscarEmpresa
                    End If

                End If

                modificar = True
                sdsPrecios.SelectParameters(0).DefaultValue = id_cotizacion
                GridView1.DataBind()
            Else
                modificar = False
                lblMensaje.Text = ""
                pnlInfo.Visible = True
                obtener_consecutivo()

                obtener_letra()
            End If

        Else
            If Session("cotizador") = 1 Then
                PlaceHolder1.Controls.Clear()
                Dim configuracion_cotizador As UserControl = LoadControl("~/controles_usuario/configurar_cotizador.ascx")
                PlaceHolder1.Controls.Add(configuracion_cotizador)
            End If
            If Session("nueva_empresa") = 1 Then
                PlaceHolder1.Controls.Clear()
                Dim nueva_empresa As UserControl = LoadControl("~/controles_usuario/CtlNuevaEmpresa.ascx")
                PlaceHolder1.Controls.Add(nueva_empresa)
                Session("tipo_empresa") = 1

            End If
            If Session("nuevo_contacto") = 1 Then
                PlaceHolder1.Controls.Clear()
                Dim nuevo_contacto As UserControl = LoadControl("~/controles_usuario/CtlNuevoContacto.ascx")
                PlaceHolder1.Controls.Add(nuevo_contacto)
            End If
            If Session("ctlConceptos") Then
                PlaceHolder1.Controls.Clear()
                Dim nuevo_contacto As UserControl = LoadControl("~/controles_usuario/CtlConceptosCotizacion.ascx")
                PlaceHolder1.Controls.Add(nuevo_contacto)
            End If

        End If
    End Sub
    Protected Sub obtener_consecutivo()
        Dim buscar_ultimo_consecutivo = (From consulta In db.cotizaciones
                                         Where consulta.ano = Now.AddHours(-7).Year()
                                        Select consulta Order By consulta.consecutivo Descending).FirstOrDefault()

        Dim siguiente_consecutivo As Integer = 0

        If Not buscar_ultimo_consecutivo Is Nothing Then
            siguiente_consecutivo = buscar_ultimo_consecutivo.consecutivo + 1
        Else
            siguiente_consecutivo = 1
        End If

        lblAno.Text = Now.AddHours(-7).Year
        lblConsecutivo.Text = siguiente_consecutivo

    End Sub

    Protected Sub actualizar_configuracion()
        Dim buscar_configuracion_cotizador = (From consulta In db.configuracion_cotizadors
                                                       Select consulta).FirstOrDefault()

        Dim buscar_precio_combustible = (From consulta In db.costo_combustibles
                                         Where consulta.tipo_combustible = 1
                                        Select consulta Order By consulta.precio Descending).FirstOrDefault()


        If Not buscar_configuracion_cotizador Is Nothing Then
            lblCostoxKilometro.Text = buscar_configuracion_cotizador.costo_kilometro

            lblRendimiento.Text = buscar_configuracion_cotizador.rendimiento_tracto
            lblTarifaChofer.Text = buscar_configuracion_cotizador.porcentaje_chofer

            If Not buscar_precio_combustible Is Nothing Then
                txbPrecioDiesel.Text = String.Format("{0:c2}", buscar_precio_combustible.precio)
            End If

            lblVigencia.Text = buscar_configuracion_cotizador.meses_vigencia
        Else
            lblMensaje.Text = "Primero ingrese los parametros del cotizador."
        End If
    End Sub
    Protected Sub sacar_rendimiento()
        Dim tipo_vehiculo = ddlVehiculo.SelectedValue
        Dim buscar_rendimiento = (From consulta In db.configuracion_cotizadors
                               Select consulta).FirstOrDefault()

        If Not buscar_rendimiento Is Nothing Then
            Select Case tipo_vehiculo
                Case 102
                    lblRendimiento.Text = buscar_rendimiento.rendimiento_tracto
                Case 103
                    lblRendimiento.Text = buscar_rendimiento.rendimiento_rabon
                Case 105
                    lblRendimiento.Text = buscar_rendimiento.rendimiento_pickup
                Case 109
                    lblRendimiento.Text = buscar_rendimiento.rendimiento_Plataforma
            End Select
        End If
    End Sub
    Function buscar_ruta()
        Dim id_ruta_buscada As Integer = 0

        Dim buscar_ruta_registrada = (From consulta In db.llave_rutas
                        Where consulta.ruta = lblRuta.Text
                        Select consulta).FirstOrDefault()

        If Not buscar_ruta_registrada Is Nothing Then
            id_ruta_buscada = buscar_ruta_registrada.id_ruta
        End If
        Return id_ruta_buscada
    End Function
   
    Protected Sub obtener_precio()
        Dim tipo_vehiculo = ddlVehiculo.SelectedValue
        Dim factor_retorno As Decimal = 1
        Dim buscar_configuracion = (From consulta In db.configuracion_cotizadors
                                 Select consulta).FirstOrDefault()

        Dim factor_vehiculo As Decimal = 0


        Dim descuento As Decimal = 0
        Dim incremento As Decimal = 0

        If Not String.IsNullOrEmpty(txbDescuento.Text) Then
            descuento = txbDescuento.Text
        End If

        If Not String.IsNullOrEmpty(txbIncremento.Text) Then
            incremento = txbIncremento.Text
        End If

        If Not buscar_configuracion Is Nothing Then

            Select Case tipo_vehiculo
                Case 102
                    factor_vehiculo = 1
                Case 109
                    factor_vehiculo = 1
                Case 103
                    factor_vehiculo = (buscar_configuracion.manejo_rabon) / 100
                Case 105
                    factor_vehiculo = (buscar_configuracion.manejo_pickup) / 100
            End Select

        End If
        Dim rendimiento As Decimal = CDec(lblRendimiento.Text)

        Dim costo_operacion As Decimal = 0
        Dim precio_cotizacion As Decimal = 0
        Dim casetas_regreso As Decimal = 0
        Dim diesel_regreso As Decimal = 0

        ''casetas
        If Not String.IsNullOrEmpty(txbCasetas.Text) Then
            lblCasetas.Text = String.Format("{0:c2}", CDec(txbCasetas.Text))

            If tipo_vehiculo > 102 Then
                casetas_regreso = CDec(txbCasetas.Text)
            End If

            costo_operacion = CDec(txbCasetas.Text)
        End If

        ''diesel
        If Not String.IsNullOrEmpty(txbPrecioDiesel.Text) And
            Not String.IsNullOrEmpty(lblRendimiento.Text) And
            Not String.IsNullOrEmpty(txbKms.Text) Then

            Dim kms As Decimal = CDec(txbKms.Text)

            Dim precio_diesel As Decimal = CDec(txbPrecioDiesel.Text)

            Dim costo_diesel = (kms / rendimiento) * precio_diesel


            If tipo_vehiculo > 102 Then
                diesel_regreso = costo_diesel
            End If

            lblDiesel.Text = String.Format("{0:c2}", costo_diesel)
            costo_operacion += costo_diesel

        End If

        ''chofer
        If Not String.IsNullOrEmpty(lblCostoxKilometro.Text) And
            Not String.IsNullOrEmpty(lblTarifaChofer.Text) Then

            Dim Ganancia_por_kilometro As Decimal = CDec(lblCostoxKilometro.Text)
            Dim porcentaje_tarifa_chofer As Decimal = CDec(lblTarifaChofer.Text) / 100
            Dim kms As Integer = CInt(txbKms.Text)

            Dim tarifa_chofer = (kms * Ganancia_por_kilometro * porcentaje_tarifa_chofer) * factor_vehiculo
            lblChofer.Text = String.Format("{0:c2}", tarifa_chofer)
            costo_operacion += tarifa_chofer

        End If


        If RadioButtonList1.SelectedValue = 1 Then
            factor_retorno = ((buscar_configuracion.factor_retorno) / 100) + 1
        End If

        precio_cotizacion = ((costo_operacion * 2) + casetas_regreso + diesel_regreso) * factor_retorno

        Dim buscarOtrosCargos = From consulta In db.CargosAdicionales
                              Where consulta.RelacionId Is Nothing
                              Select consulta

        Dim cargosAdicionales As Decimal = 0
        For Each cargo In buscarOtrosCargos
            cargosAdicionales += cargo.cargo
        Next
        lblOtros.Text = String.Format("{0:c}", cargosAdicionales)
        precio_cotizacion += cargosAdicionales

        precio_cotizacion += incremento
        precio_cotizacion -= descuento

        Dim tipo_cambio = txbTipoCambio.Text

        Dim Precio_dolares As Decimal = 0

        If ddlMoneda.SelectedValue = 5 And Not String.IsNullOrEmpty(tipo_cambio) Then
            Precio_dolares = precio_cotizacion / CDec(tipo_cambio)
            lblMoneda.Text = "Dlls."
            lblPrecioDlls.Text = String.Format("{0:c2}", Precio_dolares)
        End If

        lblPrecio.Text = String.Format("{0:c2}", precio_cotizacion)


        lblCosto.Text = String.Format("{0:c2}", costo_operacion)

        If Not String.IsNullOrEmpty(txbPrecioDiesel.Text) Then
            If Not buscar_configuracion Is Nothing Then
                buscar_configuracion.precio_diesel = txbPrecioDiesel.Text
                db.SubmitChanges()
            End If
        End If
    End Sub
    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        obtener_precio()
    End Sub
    Protected Sub btnConfigurar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnConfigurar.Click
        Session("cotizador") = 1
        mdlConfiguracion.Show()
        PlaceHolder1.Controls.Clear()

        Dim configuracion_cotizador As UserControl = LoadControl("~/controles_usuario/configurar_cotizador.ascx")
        PlaceHolder1.Controls.Add(configuracion_cotizador)
    End Sub

    Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click
        PlaceHolder1.Controls.Clear()
        mdlConfiguracion.Hide()
        actualizar_configuracion()
        ddlEmpresa.DataBind()
        ddlContacto.DataBind()
        ddlConceptos.DataBind()
        Session("cotizador") = 0
        Session("nueva_empresa") = 0
        Session("nuevo_contacto") = 0
        Session("ctlConceptos") = False
    End Sub

    Protected Sub ddlVehiculo_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlVehiculo.SelectedIndexChanged

        sacar_rendimiento()

    End Sub
    
    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click


        Dim nuevaCotizacion As New wcfRef1.cotizacione()

        Dim id_ruta_cotizada As Integer = 0
        Dim tipo_vehiculo = ddlVehiculo.SelectedValue
        Dim id_empresa = ddlEmpresa.SelectedValue
        Dim id_moneda = ddlMoneda.SelectedValue
        Dim comentarios = txbComentarios.Text
        Dim precio = lblPrecio.Text
        Dim ruta_sin_guion As String = lblRuta.Text




        If RadioButtonList1.SelectedValue = 0 Then

            Dim ultimoCaracter = lblRuta.Text.Substring(ruta_sin_guion.Length - 1)

            If ultimoCaracter = "-" Then
                ruta_sin_guion = lblRuta.Text.Substring(0, ruta_sin_guion.Length - 1)
                lblRuta.Text = ruta_sin_guion
            End If

        End If

        If ddlMoneda.SelectedValue = 5 Then
            precio = lblPrecioDlls.Text
        End If

        If Not String.IsNullOrEmpty(lblPrecio.Text) Then
            Dim id_ruta = buscar_ruta()

            If id_ruta <> 0 Then
                insertar_precio(id_empresa, comentarios, id_ruta, precio, tipo_vehiculo)
            Else
                crear_ruta()
                id_ruta = buscar_ruta()
                insertar_precio(id_empresa, comentarios, id_ruta, precio, tipo_vehiculo)
            End If

            pnlInfo.Visible = False
            lblMensaje.Text = "Se guardó la información."
            Dim buscar_cotizacion = (From consulta In db.cotizaciones
                                   Where consulta.ano = lblAno.Text And
                                   consulta.consecutivo = lblConsecutivo.Text
                                   Select consulta).FirstOrDefault()

            If Not buscar_cotizacion Is Nothing Then
                txbIdCotizacion.Text = buscar_cotizacion.id_cotizacion

            End If
            cargar_grid()
        Else
            lblMensaje.Text = "Información Incompleta."
        End If

    End Sub
    Protected Sub cargar_grid()
        Dim buscar_id_cotizacion = (From consulta In db.cotizaciones
                                            Where consulta.ano = lblAno.Text And
                                            consulta.consecutivo = lblConsecutivo.Text).FirstOrDefault()
        If Not buscar_id_cotizacion Is Nothing Then
            sdsPrecios.SelectParameters(0).DefaultValue = buscar_id_cotizacion.id_cotizacion
            sdsPrecios.DataBind()
            GridView1.DataBind()
        End If
    End Sub

    Protected Sub insertar_precio(ByVal id_empresa As Integer,
                                  ByVal comentarios As String,
                                  ByVal id_ruta_cotizada As Integer,
                                  ByVal precio As Decimal,
                                  ByVal tipo_vehiculo As Integer)




        Dim nuevaFechaAlta As New wcfRef1.fecha()

        nuevaFechaAlta.fecha1 = Now.AddHours(-7)
        nuevaFechaAlta.tipo_fecha = 8

        nuevaFechaAlta = proxy.crearFecha(nuevaFechaAlta)

        Dim ano = Now.AddHours(-7).Year
        Dim consecutivo = lblConsecutivo.Text

        Dim buscarCotizacion = proxy.buscarCotizacionPorConsecutivo(ano, consecutivo)
        Dim meses_vigencia_cotizacion = CInt(lblVigencia.Text)
        If buscarCotizacion Is Nothing Then
            Dim nuevaCotizacion As New wcfRef1.cotizacione()
            nuevaCotizacion.id_contacto = ddlContacto.Text
            nuevaCotizacion.vigencia = Now.AddHours(-7).AddMonths(meses_vigencia_cotizacion)
            nuevaCotizacion.ano = Now.AddHours(-7).Year
            nuevaCotizacion.consecutivo = lblConsecutivo.Text
            nuevaCotizacion.id_status = 9
            nuevaCotizacion.fechaCaducidadPrecio = Now.AddHours(-7).AddMonths(12)

            nuevaCotizacion = proxy.crearCotizacion(nuevaCotizacion)


            Dim nuevoPrecio As New wcfRef1.precio()
            nuevoPrecio.id_empresa = id_empresa
            nuevoPrecio.id_moneda = ddlMoneda.SelectedValue
            nuevoPrecio.especificacion = comentarios
            nuevoPrecio.factura_dolares = ckbFacturaDolares.Checked
            nuevoPrecio.id_fecha = nuevaFechaAlta.id_fecha
            nuevoPrecio.id_ruta = id_ruta_cotizada
            nuevoPrecio.precio1 = precio
            nuevoPrecio.id_status = 9
            nuevoPrecio.id_tipo_recurso = tipo_vehiculo
            nuevoPrecio.id_cotizacion = nuevaCotizacion.id_cotizacion
            nuevoPrecio.letra = lblLetra.Text
            nuevoPrecio.kms = txbKms.Text
            nuevoPrecio.casetas = txbCasetas.Text

            nuevoPrecio = proxy.crearPrecio(nuevoPrecio)


            If Not nuevoPrecio Is Nothing Then
                Dim RelacionId = nuevoPrecio.id_relacion

                Dim buscarCargosAdicionales = From consulta In db.CargosAdicionales
                                            Where consulta.RelacionId Is Nothing
                                            Select consulta

                For Each cargo In buscarCargosAdicionales
                    cargo.RelacionId = RelacionId
                    db.SubmitChanges()
                Next
            End If

        End If

    End Sub

    Protected Sub crear_ruta()
        Dim nueva_llave_ruta_string As String = lblRuta.Text


        Dim es_redondo As Boolean
        If RadioButtonList1.SelectedValue = 0 Then
            es_redondo = False
        Else
            es_redondo = True
        End If

        Dim nueva_llave_ruta As New llave_ruta With {.ruta = nueva_llave_ruta_string, .id_status = 9, .redondo = es_redondo}

        Dim ruta = txbRuta.Text

        If RadioButtonList1.SelectedValue = 1 Then
            ''si es redondo agregamos el puto de origen al final
            Dim id_punto_final = ruta.Substring(0, 10)
            ruta += id_punto_final
        End If


        Dim secuencia = 0
        For Each punto In ruta.Split(New Char() {"/"c})
            If IsNumeric(punto) Then
                secuencia += 1
                If punto = ddlOrigen.SelectedValue And secuencia = 1 Then
                    Dim nuevo_punto As New ruta With {.llave_ruta = nueva_llave_ruta,
                                                                                                .id_ubicacion = ddlOrigen.SelectedValue,
                                                                                                .id_tipo_arrivo = 1, .secuencia = secuencia}
                    db.rutas.InsertOnSubmit(nuevo_punto)
                Else
                    If punto = ddlDestino.SelectedValue Then
                        Dim nuevo_punto As New ruta With {.llave_ruta = nueva_llave_ruta,
                                                                    .id_ubicacion = ddlDestino.SelectedValue,
                                                                    .id_tipo_arrivo = 3, .secuencia = secuencia}
                        db.rutas.InsertOnSubmit(nuevo_punto)
                    Else
                        Dim nuevo_punto As New ruta With {.llave_ruta = nueva_llave_ruta,
                                                          .id_ubicacion = punto,
                                                          .id_tipo_arrivo = 2, .secuencia = secuencia}
                        db.rutas.InsertOnSubmit(nuevo_punto)
                    End If
                End If
                db.SubmitChanges()
            End If
        Next


    End Sub

    Protected Sub lnkEmpresas_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkEmpresas.Click
        Dim nueva_empresa As UserControl = LoadControl("~/controles_usuario/CtlNuevaEmpresa.ascx")
        PlaceHolder1.Controls.Clear()
        PlaceHolder1.Controls.Add(nueva_empresa)
        mdlConfiguracion.Show()
        Session("tipo_empresa") = 1
        Session("nueva_empresa") = 1
        'Server.Transfer("~/Recepcion/catalogos/clientes.aspx")
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LinkButton1.Click
        Dim nuevo_contacto As UserControl = LoadControl("~/controles_usuario/CtlNuevoContacto.ascx")
        PlaceHolder1.Controls.Clear()
        PlaceHolder1.Controls.Add(nuevo_contacto)
        mdlConfiguracion.Show()
        Session("id_empresa") = ddlEmpresa.SelectedValue
        Session("nuevo_contacto") = 1
    End Sub

    Protected Sub ddlEmpresa_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlEmpresa.DataBound

        ddlEmpresa.Items.Add(New ListItem("Seleccionar...", 0))
        If Not modificar Then
            ddlEmpresa.SelectedValue = 0
        End If

    End Sub

    Protected Sub ddlContacto_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlContacto.DataBound
        ddlContacto.Items.Add(New ListItem("Seleccionar...", 0))

    End Sub
    Protected Sub obtener_letra()
        Dim buscar_ultimo_precio_cotizacion = (From consulta In db.precios
                                                    Where consulta.cotizacione.ano = lblAno.Text And
                                                    consulta.cotizacione.consecutivo = lblConsecutivo.Text And
                                                    consulta.id_status <> 6
                                                    Select consulta Order By consulta.letra Descending).FirstOrDefault()
        
        If Not buscar_ultimo_precio_cotizacion Is Nothing Then
            Dim ultima_letra As String = buscar_ultimo_precio_cotizacion.letra
            Dim numero_caracter As Integer = Asc(ultima_letra) + 1
            Dim siguiente_letra As Char = Chr(numero_caracter)
            lblLetra.Text = siguiente_letra
        Else
            lblLetra.Text = "a"
        End If
    End Sub


    Protected Sub lnkAgregarPrecio_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkAgregarPrecio.Click
        lblMensaje.Text = ""
        obtener_letra()
        lblMensaje.Text = String.Empty
        pnlInfo.Visible = True
    End Sub

    
    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView1.SelectedIndexChanged
        Dim nueva_fila = GridView1.SelectedRow
        Dim id_relacion = nueva_fila.Cells(1).Text

        Dim buscar_precio = (From consulta In db.precios
                          Where consulta.id_relacion = id_relacion
                          Select consulta).FirstOrDefault()

        If Not buscar_precio Is Nothing Then
            buscar_precio.id_status = 6
            db.SubmitChanges()
            GridView1.DataBind()
        End If

    End Sub

   

    Protected Sub btnVerCotizacion_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnVerCotizacion.Click
        If Not String.IsNullOrEmpty(txbIdCotizacion.Text) Then
            Dim id_cotizacion = txbIdCotizacion.Text
            Response.Redirect("~/Cotizaciones/Cotizacion_final.aspx?id_cotizacion=" + id_cotizacion)
        End If

    End Sub

    Protected Sub btnRegresar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("~/Cotizaciones/Cotizaciones.aspx")
    End Sub

    Protected Sub btnOrigen_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnOrigen.Click

        Dim buscar_ubicacion = (From consulta In db.ubicaciones
                                Where consulta.id_principal = ddlOrigen.SelectedValue
                                Select consulta).FirstOrDefault()

        If Not buscar_ubicacion Is Nothing Then
            lblRuta.Text = buscar_ubicacion.ubicacion.ToString() + "-"
            txbRuta.Text = ddlOrigen.SelectedValue.ToString() + "/"
        End If

        ''Si es redondo agregamos el punto final el cual seria el mismo que el destino
        If RadioButtonList1.SelectedValue = 1 Then
            lblRuta.Text += ddlOrigen.SelectedItem.ToString()
        End If


        btnRecoleccionIda.Enabled = True
        ddlRecoleccionesIda.Enabled = True

        ddlDestino.Enabled = True
        btnDestino.Enabled = True

        btnOrigen.Enabled = False
        ddlOrigen.Enabled = False


    End Sub

    Protected Sub btnRecoleccionIda_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnRecoleccionIda.Click

        Dim ruta As String = txbRuta.Text

        Dim buscar_punto = (From consulta In db.ubicaciones
                                 Where consulta.id_principal = ddlRecoleccionesIda.SelectedValue
                                 Select consulta).FirstOrDefault()

        If Not buscar_punto Is Nothing Then
            ruta += buscar_punto.id_principal.ToString() + "/"
            txbRuta.Text = ruta
        End If
        lblRuta.Text = String.Empty

        For Each punto In ruta.Split(New Char() {"/"c, " "c})

            Dim id_principal = punto
            If IsNumeric(id_principal) Then
                Dim buscar_ubicacion = (From consulta In db.ubicaciones
                                                 Where consulta.id_principal = id_principal
                                                 Select consulta).FirstOrDefault()

                If Not buscar_ubicacion Is Nothing Then
                    lblRuta.Text += buscar_ubicacion.ubicacion.ToString() + "-"
                End If
            End If

        Next
        If RadioButtonList1.SelectedValue = 1 Then
            lblRuta.Text += ddlOrigen.SelectedItem.ToString()
        End If
    End Sub

    Protected Sub btnDestino_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnDestino.Click
       

        Dim ruta As String = txbRuta.Text

        Dim buscar_punto = (From consulta In db.ubicaciones
                                 Where consulta.id_principal = ddlDestino.SelectedValue
                                 Select consulta).FirstOrDefault()

        If Not buscar_punto Is Nothing Then
            ruta += buscar_punto.id_principal.ToString() + "/"
            txbRuta.Text = ruta
        End If
        lblRuta.Text = String.Empty

        For Each punto In ruta.Split(New Char() {"/"c, " "c})

            Dim id_principal = punto
            If IsNumeric(id_principal) Then
                Dim buscar_ubicacion = (From consulta In db.ubicaciones
                                                 Where consulta.id_principal = id_principal
                                                 Select consulta).FirstOrDefault()

                If Not buscar_ubicacion Is Nothing Then
                    lblRuta.Text += buscar_ubicacion.ubicacion.ToString() + "-"
                End If
            End If

        Next

        If RadioButtonList1.SelectedValue = 1 Then
            lblRuta.Text += ddlOrigen.SelectedItem.ToString()
        End If


        btnRecolecccionesRegreso.Enabled = True
        ddlRecoleccionesRegreso.Enabled = True

        btnDestino.Enabled = False
        ddlDestino.Enabled = False
        btnRecoleccionIda.Enabled = False
        ddlRecoleccionesIda.Enabled = False

    End Sub

    Protected Sub RadioButtonList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles RadioButtonList1.SelectedIndexChanged
        Dim ruta As String = txbRuta.Text
        lblRuta.Text = String.Empty

        For Each punto In ruta.Split(New Char() {"/"c, " "c})

            Dim id_principal = punto
            If IsNumeric(id_principal) Then
                Dim buscar_ubicacion = (From consulta In db.ubicaciones
                                                 Where consulta.id_principal = id_principal
                                                 Select consulta).FirstOrDefault()

                If Not buscar_ubicacion Is Nothing Then
                    lblRuta.Text += buscar_ubicacion.ubicacion.ToString() + "-"
                End If
            End If

        Next

        If RadioButtonList1.SelectedValue = 1 Then
            If Not String.IsNullOrEmpty(lblRuta.Text) Then
                lblRuta.Text += ddlOrigen.SelectedItem.ToString()
            End If

        End If
       

    End Sub

    Protected Sub btnRecolecccionesRegreso_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnRecolecccionesRegreso.Click
        Dim ruta As String = txbRuta.Text

        Dim buscar_punto = (From consulta In db.ubicaciones
                                 Where consulta.id_principal = ddlRecoleccionesRegreso.SelectedValue
                                 Select consulta).FirstOrDefault()

        If Not buscar_punto Is Nothing Then
            ruta += buscar_punto.id_principal.ToString() + "/"
            txbRuta.Text = ruta
        End If
        lblRuta.Text = String.Empty

        For Each punto In ruta.Split(New Char() {"/"c, " "c})

            Dim id_principal = punto
            If IsNumeric(id_principal) Then
                Dim buscar_ubicacion = (From consulta In db.ubicaciones
                                                 Where consulta.id_principal = id_principal
                                                 Select consulta).FirstOrDefault()

                If Not buscar_ubicacion Is Nothing Then
                    lblRuta.Text += buscar_ubicacion.ubicacion.ToString() + "-"
                End If
            End If

        Next

        If RadioButtonList1.SelectedValue = 1 Then
            lblRuta.Text += ddlOrigen.SelectedItem.ToString()
        End If
    End Sub

    Protected Sub btnBorrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBorrar.Click
        Dim ruta = txbRuta.Text

        Dim nueva_ruta = ruta.Substring(0, ruta.Length - 11)
        txbRuta.Text = nueva_ruta

        Dim index_inicio = ruta.Length - 11


        Dim punto_borrado = ruta.Substring(index_inicio, 10)

        lblRuta.Text = String.Empty

        If punto_borrado = ddlOrigen.SelectedValue Then
            ddlOrigen.Enabled = True
            btnOrigen.Enabled = True
            ddlDestino.Enabled = False
            btnDestino.Enabled = False
            ddlRecoleccionesIda.Enabled = False
            btnRecoleccionIda.Enabled = False
            lblRuta.Text = String.Empty
        End If


        If punto_borrado = ddlDestino.SelectedValue Then
            ddlDestino.Enabled = True
            btnDestino.Enabled = True
            ddlRecoleccionesIda.Enabled = True
            btnRecoleccionIda.Enabled = True
        End If

        For Each punto In nueva_ruta.Split(New Char() {"/"c, " "c})



            Dim id_principal = punto

           


            If IsNumeric(id_principal) Then
                Dim buscar_ubicacion = (From consulta In db.ubicaciones
                                                 Where consulta.id_principal = id_principal
                                                 Select consulta).FirstOrDefault()

                If Not buscar_ubicacion Is Nothing Then
                    lblRuta.Text += buscar_ubicacion.ubicacion.ToString() + "-"
                End If
            End If

        Next

        If RadioButtonList1.SelectedValue = 1 Then
            lblRuta.Text += ddlOrigen.SelectedItem.ToString()
        End If

    End Sub

    
    Protected Sub ddlConceptos_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlConceptos.DataBound
        ddlConceptos.Items.Add(Crear_item("Seleccionar..", 0))
    End Sub

    Protected Sub lnkConceptos_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkConceptos.Click
        Session("ctlConceptos") = True
        Dim ctlConceptos As UserControl = LoadControl("~/Controles_Usuario/ctlConceptosCotizacion.ascx")
        PlaceHolder1.Controls.Add(ctlConceptos)
        mdlConfiguracion.Show()
    End Sub

    Protected Sub btnAgregar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnAgregar.Click
        If ddlConceptos.SelectedValue <> 0 Then
            Dim agregarConcepto As New CargosAdicionale With {.ConceptoId = ddlConceptos.SelectedValue, .cargo = txbCantidad.Text}
            db.CargosAdicionales.InsertOnSubmit(agregarConcepto)
            db.SubmitChanges()
            GridView2.DataBind()
        End If

    End Sub
End Class