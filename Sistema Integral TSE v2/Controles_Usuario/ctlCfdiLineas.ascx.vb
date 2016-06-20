Imports DGMC.TimbraCFDI
Imports iTextSharp
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.text.html.simpleparser
Imports System.IO

Public Class ctlCfdiLineas
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Dim db2 As New DataClasses2DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ponerFecha()
            Dim buscarIvaTraslado = (From consulta In db2.parametros
                                Where consulta.variable = "tasaIvaTraslado"
                                Select consulta).FirstOrDefault()

            If Not buscarIvaTraslado Is Nothing Then
                txbTasaIva.Text = Decimal.Parse(buscarIvaTraslado.valor)
            End If

            Dim buscarIvaRetenido = (From consulta In db2.parametros
                                Where consulta.variable = "tasaIvaRetenido"
                                Select consulta).FirstOrDefault()

            If Not buscarIvaRetenido Is Nothing Then
                txbTasaRetencion.Text = Decimal.Parse(buscarIvaRetenido.valor)
            End If

        End If
    End Sub
    Public Sub limpiar_formulario()
        lblCiudad.Text = ""
        lblDireccion.Text = ""

        lblNombre.Text = ""

        txbDescripcion2.Text = String.Empty
        lblImporte1.Text = String.Empty
        lblImporte2.Text = String.Empty
        lblImporte3.Text = String.Empty
        lblImporte4.Text = String.Empty
        lblImporte5.Text = String.Empty
        lblImporte6.Text = String.Empty
        lblImporte7.Text = String.Empty
        lblImporte8.Text = String.Empty
        lblImporte9.Text = String.Empty
        lblImporte10.Text = String.Empty
        lblImporte11.Text = String.Empty
        lblImporte12.Text = String.Empty
        lblImporte13.Text = String.Empty
        lblImporte14.Text = String.Empty
        lblImporte15.Text = String.Empty

        lblSubtotal.Text = String.Empty
        lblTotal.Text = String.Empty

        Dim txt As TextBox
        Dim lnk As LinkButton
        Dim ckb As CheckBox

        For Each x In Me.Controls
            If x.GetType() Is GetType(TextBox) Then
                txt = CType(x, TextBox)
                txt.Text = ""
            End If
            If x.GetType() Is GetType(LinkButton) Then
                lnk = CType(x, LinkButton)
                lnk.Visible = False
            End If
            If x.GetType() Is GetType(CheckBox) Then
                ckb = CType(x, CheckBox)
                ckb.Checked = False
            End If
        Next

        txbCantidadLetra.Text = ""

        lblSubtotal.Text = ""

        lblRetencion.Text = ""
        'txtRetencion.Text = ""
        lblRfc.Text = ""
        lblMensajeCBB.Text = String.Empty
        lblMensajeCFDI.Text = String.Empty
        lblMensajePdf.Text = String.Empty

        lblTelefono.Text = ""
        lblTotal.Text = ""
        ddlMetodoPago.SelectedIndex = 0
        'ddlMetodoPago.SelectedItem.Selected = True
        'ddlMetodoPago.Items.FindByValue("Transferencia").Selected = True
    End Sub
    Public Sub ponerFecha()
        Dim dia = Now.AddHours(-7).Day()
        Dim mes = Now.AddHours(-7).Month()
        Dim ano = Now.AddHours(-7).Year()
    End Sub
    Public Sub crearEncabezado(ByVal idDato As Integer)
        Dim datos = (From consulta In db.datos_facturacions
                    Where consulta.id_dato = idDato
                    Select consulta).FirstOrDefault()

        Dim razon_social = datos.razon_social

        lblNombre.Text = datos.razon_social
        lblRfc.Text = datos.rfc
        lblTelefono.Text = datos.telefono

        Dim direccion = String.Format("{0} {1}", datos.calle, datos.noExterior)

        lblDireccion.Text = String.Format("{0}, {1}", direccion, datos.colonia)
        lblCiudad.Text = String.Format("{0}, {1}, {2}", datos.municipio, datos.estado, datos.c_postal)
    End Sub
    Public Sub asignarTipoComprobante(ByVal tipoComprobante As Integer)
        ddlTipoComprobante.SelectedValue = tipoComprobante
    End Sub
    Public Function regresarTotal()
        Dim total = lblTotal.Text
        Return total
    End Function
    Public Function regresarRetencion()
        Dim retencion = lblRetencion.Text
        'Dim retencion = txtRetencion.Text

        Return retencion
    End Function
    Public Function regresarIva()
        Dim iva = lblIva.Text
        Return iva
    End Function
    Public Function regresarSubtotal()
        Dim subtotal = lblSubtotal.Text
        Return subtotal
    End Function
    Public Function regresarDescripcion(ByVal renglon As Integer) As String
        Dim result = String.Empty

        Select Case renglon
            Case 1
                result = txbDescripcion1.Text
            Case 2
                result = txbDescripcion2.Text
            Case 3
                result = txbDescripcion3.Text
            Case 4
                result = txbDescripcion4.Text
            Case 5
                result = txbDescripcion5.Text
            Case 6
                result = txbDescripcion6.Text
            Case 7
                result = txbDescripcion7.Text
            Case 8
                result = txbDescripcion8.Text
            Case 9
                result = txbDescripcion9.Text
            Case 10
                result = txbDescripcion10.Text
            Case 11
                result = txbDescripcion11.Text
            Case 12
                result = txbDescripcion12.Text
            Case 13
                result = txbDescripcion13.Text
            Case 14
                result = txbDescripcion14.Text
            Case 15
                result = txbDescripcion15.Text
        End Select


        Return result
    End Function

    Public Function regresarDescripciones() As List(Of String)
        Dim result As New List(Of String)

        If Not String.IsNullOrEmpty(txbDescripcion1.Text) Then
            result.Add(txbDescripcion1.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion2.Text) Then
            result.Add(txbDescripcion2.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion3.Text) Then
            result.Add(txbDescripcion3.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion4.Text) Then
            result.Add(txbDescripcion4.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion5.Text) Then
            result.Add(txbDescripcion5.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion6.Text) Then
            result.Add(txbDescripcion6.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion7.Text) Then
            result.Add(txbDescripcion7.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion8.Text) Then
            result.Add(txbDescripcion8.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion9.Text) Then
            result.Add(txbDescripcion9.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion10.Text) Then
            result.Add(txbDescripcion10.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion11.Text) Then
            result.Add(txbDescripcion11.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion12.Text) Then
            result.Add(txbDescripcion12.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion13.Text) Then
            result.Add(txbDescripcion13.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion14.Text) Then
            result.Add(txbDescripcion14.Text)
        End If
        If Not String.IsNullOrEmpty(txbDescripcion15.Text) Then
            result.Add(txbDescripcion15.Text)
        End If
        Return result
    End Function


    Public Function regresarCantidad(ByVal renglon As Integer) As String
        Dim result = String.Empty

        Select Case renglon
            Case 1
                result = txbCantidad1.Text
            Case 2
                result = txbCantidad2.Text
            Case 3
                result = txbCantidad3.Text
            Case 4
                result = txbCantidad4.Text
            Case 5
                result = txbCantidad5.Text
            Case 6
                result = txbCantidad6.Text
            Case 7
                result = txbCantidad7.Text
            Case 8
                result = txbCantidad8.Text
            Case 9
                result = txbCantidad9.Text
            Case 10
                result = txbCantidad10.Text
            Case 11
                result = txbCantidad11.Text
            Case 12
                result = txbCantidad12.Text
            Case 13
                result = txbCantidad13.Text
            Case 14
                result = txbCantidad14.Text
            Case 15
                result = txbCantidad15.Text
        End Select


        Return result
    End Function

    Public Function regresarValorUnitario(ByVal renglon As Integer) As Decimal
        Dim result As Decimal = 0.0

        Select Case renglon
            Case 1
                result = txbPrecio1.Text
            Case 2
                result = txbPrecio2.Text
            Case 3
                result = txbPrecio3.Text
            Case 4
                result = txbPrecio4.Text
            Case 5
                result = txbPrecio5.Text
            Case 6
                result = txbPrecio6.Text
            Case 7
                result = txbPrecio7.Text
            Case 8
                result = txbPrecio8.Text
            Case 9
                result = txbPrecio9.Text
            Case 10
                result = txbPrecio10.Text
            Case 11
                result = txbPrecio11.Text
            Case 12
                result = txbPrecio12.Text
            Case 13
                result = txbPrecio13.Text
            Case 14
                result = txbPrecio14.Text
            Case 15
                result = txbPrecio15.Text
        End Select


        Return result
    End Function
    Public Function regresarImporte(ByVal renglon As Integer) As Decimal
        Dim result As Decimal = 0.0

        Select Case renglon
            Case 1
                result = lblImporte1.Text
            Case 2
                result = lblImporte2.Text
            Case 3
                result = lblImporte3.Text
            Case 4
                result = lblImporte4.Text
            Case 5
                result = lblImporte5.Text
            Case 6
                result = lblImporte6.Text
            Case 7
                result = lblImporte7.Text
            Case 8
                result = lblImporte8.Text
            Case 9
                result = lblImporte9.Text
            Case 10
                result = lblImporte10.Text
            Case 11
                result = lblImporte11.Text
            Case 12
                result = lblImporte12.Text
            Case 13
                result = lblImporte13.Text
            Case 14
                result = lblImporte14.Text
            Case 15
                result = lblImporte15.Text
        End Select


        Return result
    End Function



    Public Sub agregarRenglon(ByVal cantidad As Integer,
                              ByVal descripcion As String,
                              ByVal valorUnitario As Decimal
                              )

        If String.IsNullOrEmpty(txbDescripcion1.Text) Then
            txbDescripcion1.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete1.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion2.Text) Then
            txbDescripcion2.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete2.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion3.Text) Then
            txbDescripcion3.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete2.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion4.Text) Then
            txbDescripcion4.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete4.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion5.Text) Then
            txbDescripcion5.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete5.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion6.Text) Then
            txbDescripcion6.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete6.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion7.Text) Then
            txbDescripcion7.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete7.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion8.Text) Then
            txbDescripcion8.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete8.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion9.Text) Then
            txbDescripcion9.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete9.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion10.Text) Then
            txbDescripcion10.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete10.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion11.Text) Then
            txbDescripcion11.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete11.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion12.Text) Then
            txbDescripcion12.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete12.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion13.Text) Then
            txbDescripcion13.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete13.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion14.Text) Then
            txbDescripcion14.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete14.Checked = False
        ElseIf String.IsNullOrEmpty(txbDescripcion15.Text) Then
            txbDescripcion15.Text = String.Format("{0}{1}", descripcion, vbNewLine)
            chkFlete15.Checked = False
        End If



        If String.IsNullOrEmpty(txbPrecio1.Text) Then
            txbPrecio1.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio2.Text) Then
            txbPrecio2.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio3.Text) Then
            txbPrecio3.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio4.Text) Then
            txbPrecio4.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio5.Text) Then
            txbPrecio5.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio6.Text) Then
            txbPrecio6.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio7.Text) Then
            txbPrecio7.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio8.Text) Then
            txbPrecio8.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio9.Text) Then
            txbPrecio9.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio10.Text) Then
            txbPrecio10.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio11.Text) Then
            txbPrecio11.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio12.Text) Then
            txbPrecio12.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio13.Text) Then
            txbPrecio13.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio14.Text) Then
            txbPrecio14.Text = String.Format("{0:c2}", valorUnitario)
        ElseIf String.IsNullOrEmpty(txbPrecio15.Text) Then
            txbPrecio15.Text = String.Format("{0:c2}", valorUnitario)
        End If

        If String.IsNullOrEmpty(txbCantidad1.Text) Then
            txbCantidad1.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad2.Text) Then
            txbCantidad2.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad3.Text) Then
            txbCantidad3.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad4.Text) Then
            txbCantidad4.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad5.Text) Then
            txbCantidad5.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad6.Text) Then
            txbCantidad6.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad7.Text) Then
            txbCantidad7.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad8.Text) Then
            txbCantidad8.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad9.Text) Then
            txbCantidad9.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad10.Text) Then
            txbCantidad10.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad11.Text) Then
            txbCantidad11.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad12.Text) Then
            txbCantidad12.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad13.Text) Then
            txbCantidad13.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad14.Text) Then
            txbCantidad14.Text = cantidad
        ElseIf String.IsNullOrEmpty(txbCantidad15.Text) Then
            txbCantidad15.Text = cantidad
        End If

        If String.IsNullOrEmpty(lblImporte1.Text) Then
            lblImporte1.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte2.Text) Then
            lblImporte2.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte3.Text) Then
            lblImporte3.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte4.Text) Then
            lblImporte4.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte5.Text) Then
            lblImporte5.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte6.Text) Then
            lblImporte6.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte7.Text) Then
            lblImporte7.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte8.Text) Then
            lblImporte8.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte9.Text) Then
            lblImporte9.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte10.Text) Then
            lblImporte10.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte11.Text) Then
            lblImporte11.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte12.Text) Then
            lblImporte12.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte13.Text) Then
            lblImporte13.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte14.Text) Then
            lblImporte14.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        ElseIf String.IsNullOrEmpty(lblImporte15.Text) Then
            lblImporte15.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        End If
    End Sub

    Public Sub agregarAnotaciones(ByVal anotacion As String)
        txbAnotaciones.Text += anotacion
    End Sub
    Public Sub borrarAnotacion()
        txbAnotaciones.Text = String.Empty
    End Sub

    Public Sub poner()

    End Sub

    Public Sub calcularTotal()

        Dim retencion As Decimal = 0
        Dim subtotal As Decimal = 0
        Dim subtotalRetencion As Decimal = 0
        Dim subtotalIva As Decimal = 0
        Dim cantidad As Integer = 0
        Dim precio As Decimal = 0D
        Dim importe As Decimal = 0D

        If IsNumeric(txbPrecio1.Text) Then
            precio = txbPrecio1.Text
            txbPrecio1.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio1.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad1.Text), 1, txbCantidad1.Text)
            txbCantidad1.Text = cantidad
            importe = precio * cantidad

            lblImporte1.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete1.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva1.Checked Then
                subtotalIva += importe
            End If
        End If

        If IsNumeric(txbPrecio2.Text) Then
            precio = txbPrecio2.Text
            txbPrecio2.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio2.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad2.Text), 1, txbCantidad2.Text)
            txbCantidad2.Text = cantidad
            importe = precio * cantidad

            lblImporte2.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete2.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva2.Checked Then
                subtotalIva += importe
            End If
        End If

        If IsNumeric(txbPrecio3.Text) Then
            precio = txbPrecio3.Text
            txbPrecio3.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio3.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad3.Text), 1, txbCantidad3.Text)
            txbCantidad3.Text = cantidad
            importe = precio * cantidad

            lblImporte3.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete3.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva3.Checked Then
                subtotalIva += importe
            End If
        End If
        If IsNumeric(txbPrecio4.Text) Then
            precio = txbPrecio4.Text
            txbPrecio4.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio4.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad4.Text), 1, txbCantidad4.Text)
            txbCantidad4.Text = cantidad
            importe = precio * cantidad

            lblImporte4.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete4.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva4.Checked Then
                subtotalIva += importe
            End If
        End If
        If IsNumeric(txbPrecio5.Text) Then
            precio = txbPrecio5.Text
            txbPrecio5.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio5.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad5.Text), 1, txbCantidad5.Text)
            txbCantidad5.Text = cantidad
            importe = precio * cantidad

            lblImporte5.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete5.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva5.Checked Then
                subtotalIva += importe
            End If
        End If
        If IsNumeric(txbPrecio6.Text) Then
            precio = txbPrecio6.Text
            txbPrecio6.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio6.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad6.Text), 1, txbCantidad6.Text)
            txbCantidad6.Text = cantidad
            importe = precio * cantidad

            lblImporte6.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete6.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva6.Checked Then
                subtotalIva += importe
            End If
        End If
        If IsNumeric(txbPrecio7.Text) Then
            precio = txbPrecio7.Text
            txbPrecio7.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio7.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad7.Text), 1, txbCantidad7.Text)
            txbCantidad7.Text = cantidad
            importe = precio * cantidad

            lblImporte7.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete7.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva7.Checked Then
                subtotalIva += importe
            End If
        End If
        If IsNumeric(txbPrecio8.Text) Then
            precio = txbPrecio8.Text
            txbPrecio8.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio8.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad8.Text), 1, txbCantidad8.Text)
            txbCantidad8.Text = cantidad
            importe = precio * cantidad

            lblImporte8.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete8.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva8.Checked Then
                subtotalIva += importe
            End If
        End If
        If IsNumeric(txbPrecio9.Text) Then
            precio = txbPrecio9.Text
            txbPrecio9.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio9.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad9.Text), 1, txbCantidad9.Text)
            txbCantidad9.Text = cantidad
            importe = precio * cantidad

            lblImporte9.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete9.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva9.Checked Then
                subtotalIva += importe
            End If
        End If
        If IsNumeric(txbPrecio10.Text) Then
            precio = txbPrecio10.Text
            txbPrecio10.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio10.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad10.Text), 1, txbCantidad10.Text)
            txbCantidad10.Text = cantidad
            importe = precio * cantidad

            lblImporte10.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete10.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva10.Checked Then
                subtotalIva += importe
            End If
        End If
        If IsNumeric(txbPrecio11.Text) Then
            precio = txbPrecio11.Text
            txbPrecio11.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio11.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad11.Text), 1, txbCantidad11.Text)
            txbCantidad11.Text = cantidad
            importe = precio * cantidad

            lblImporte11.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete11.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva11.Checked Then
                subtotalIva += importe
            End If
        End If
        If IsNumeric(txbPrecio12.Text) Then
            precio = txbPrecio12.Text
            txbPrecio12.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio12.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad12.Text), 1, txbCantidad12.Text)
            txbCantidad12.Text = cantidad
            importe = precio * cantidad

            lblImporte12.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete12.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva12.Checked Then
                subtotalIva += importe
            End If
        End If
        If IsNumeric(txbPrecio13.Text) Then
            precio = txbPrecio13.Text
            txbPrecio13.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio13.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad13.Text), 1, txbCantidad13.Text)
            txbCantidad13.Text = cantidad
            importe = precio * cantidad

            lblImporte13.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete13.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva13.Checked Then
                subtotalIva += importe
            End If
        End If
        If IsNumeric(txbPrecio14.Text) Then
            precio = txbPrecio14.Text
            txbPrecio14.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio14.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad14.Text), 1, txbCantidad14.Text)
            txbCantidad14.Text = cantidad
            importe = precio * cantidad

            lblImporte14.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete14.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva14.Checked Then
                subtotalIva += importe
            End If
        End If
        If IsNumeric(txbPrecio15.Text) Then
            precio = txbPrecio15.Text
            txbPrecio15.Text = String.Format("{0:c2}", Convert.ToDecimal(txbPrecio15.Text.Replace("$", "")))
            cantidad = IIf(String.IsNullOrEmpty(txbCantidad15.Text), 1, txbCantidad15.Text)
            txbCantidad15.Text = cantidad
            importe = precio * cantidad

            lblImporte15.Text = String.Format("{0:c2}", importe)
            subtotal += importe
            If Not chkFlete15.Checked Then
                subtotalRetencion += importe
            End If
            If Not ChkIva15.Checked Then
                subtotalIva += importe
            End If
        End If

        Dim tasaIva As Decimal
        Dim tasaRetencion As Decimal

        Try
            tasaIva = Decimal.Parse(txbTasaIva.Text)
        Catch ex As Exception
            tasaIva = 0
        End Try

        Try
            tasaRetencion = Decimal.Parse(txbTasaRetencion.Text)
        Catch ex As Exception
            tasaRetencion = 0
        End Try

        tasaIva /= 100
        tasaRetencion /= 100

        retencion = subtotalRetencion * tasaRetencion

        'Dim iva = subtotal * tasaIva
        Dim iva = subtotalIva * tasaIva
        Dim total = subtotal - retencion + iva

        lblSubtotal.Text = String.Format("{0:c2}", subtotal)
        lblIva.Text = String.Format("{0:c2}", iva)
        lblRetencion.Text = String.Format("{0:c2}", retencion)
        'txtRetencion.Text = String.Format("{0:c2}", retencion)
        lblTotal.Text = String.Format("{0:c2}", total)

        Dim facturaDolares = False
        If rbtnMoneda.SelectedValue = "Dolares" Then
            facturaDolares = True
        End If

        Dim cantidad_letra As String = Letras(String.Format("{0:f2}", total), facturaDolares)
        txbCantidadLetra.Text = StrConv(cantidad_letra, VbStrConv.Uppercase)

    End Sub

    Public Sub asignarMoneda(ByVal moneda As Integer)
        If moneda = 4 Then
            rbtnMoneda.SelectedValue = "Pesos"
        Else
            rbtnMoneda.SelectedValue = "Dolares"
        End If
    End Sub

    Public Function facturaEnDolares() As Boolean
        Dim resultado = False

        If rbtnMoneda.SelectedValue = "Dolares" Then
            resultado = True
        End If

        Return resultado

    End Function

    Public Function generarComprobante(ByVal idDato As Integer) As Comprobante
        Dim datos = (From consulta In db.datos_facturacions
                    Where consulta.id_dato = idDato
                    Select consulta).FirstOrDefault()

        Dim orden = String.Empty
        Dim rutaa = String.Empty

        Dim precioUnitario As Decimal = 0

        Dim comprobante As New Comprobante()

        Dim folio = 0

        'TIPO DE COMPROBANTE 
        'Ingreso: Factura 1, Rec honorarios 4, rec de arrendamiento 5, Rec donativos 7, Nota de cargo 3
        'Egreso: Nota de credito 2
        'Traslado: Carta porte  6
        Select Case ddlTipoComprobante.SelectedValue
            Case 0
                comprobante.tipoDeComprobante = ComprobanteTipoDeComprobante.ingreso
                folio = obtenerNuevoFolioCFDI()
            Case 1
                comprobante.tipoDeComprobante = ComprobanteTipoDeComprobante.egreso
                folio = obtenerFolioNotaCredito()
        End Select

        comprobante.serie = Now.AddHours(-7).Year()
        comprobante.fecha = DateTime.Now.AddHours(-7)
        comprobante.folio = folio
        comprobante.formaDePago = ddlFormaPago.SelectedValue
        comprobante.metodoDePago = ddlMetodoPago.SelectedValue
        comprobante.Moneda = rbtnMoneda.SelectedValue

        If Not String.IsNullOrEmpty(txbCtaPago.Text) Then
            comprobante.NumCtaPago = txbCtaPago.Text
        End If

        comprobante.LugarExpedicion = "México, Chihuahua, Chih."

        Dim subtotal As Decimal = regresarSubtotal()
        comprobante.subTotal = subtotal

        Dim total As Decimal = regresarTotal()
        comprobante.total = total

        'Llenamos datos del emisor'
        comprobante.Emisor = New ComprobanteEmisor

        'produccion
        comprobante.Emisor.rfc = "CALL630921V68"

        'prueba
        'comprobante.Emisor.rfc = "AAA010101AAA"

        comprobante.Emisor.nombre = "Luis Carlos Chávez Loya"

        'Llenamos domicilio fiscal del emisor'
        comprobante.Emisor.DomicilioFiscal = New t_UbicacionFiscal
        comprobante.Emisor.DomicilioFiscal.calle = "Av. Octavio Paz"
        comprobante.Emisor.DomicilioFiscal.noExterior = "170"
        comprobante.Emisor.DomicilioFiscal.colonia = "Complejo Industrial Chihuahua"
        comprobante.Emisor.DomicilioFiscal.municipio = "Chihuahua"
        comprobante.Emisor.DomicilioFiscal.estado = "Chihuahua"
        comprobante.Emisor.DomicilioFiscal.pais = "México"
        comprobante.Emisor.DomicilioFiscal.codigoPostal = "31109"


        'Llenamos regimen fiscal del emisor'
        Dim regimenFiscal(0) As ComprobanteEmisorRegimenFiscal
        regimenFiscal(0) = New ComprobanteEmisorRegimenFiscal
        regimenFiscal(0).Regimen = "Régimen general de ley personas físicas"
        comprobante.Emisor.RegimenFiscal = regimenFiscal

        Dim descripcionArreglo(14) As String
        Dim importeArreglo(14) As Decimal
        Dim precioArreglo(14) As Decimal
        Dim cantidad(14) As Integer

        Dim contador = 0

        If Not String.IsNullOrEmpty(txbDescripcion1.Text) Then
            descripcionArreglo(0) = txbDescripcion1.Text
            importeArreglo(0) = lblImporte1.Text
            precioArreglo(0) = txbPrecio1.Text
            cantidad(0) = txbCantidad1.Text
            contador += 1
        End If

        If Not String.IsNullOrEmpty(txbDescripcion2.Text) Then
            descripcionArreglo(1) = txbDescripcion2.Text
            precioArreglo(1) = txbPrecio2.Text
            importeArreglo(1) = lblImporte2.Text
            cantidad(1) = txbCantidad2.Text
            contador += 1
        End If

        If Not String.IsNullOrEmpty(txbDescripcion3.Text) Then
            descripcionArreglo(2) = txbDescripcion3.Text
            precioArreglo(2) = txbPrecio3.Text
            importeArreglo(2) = lblImporte3.Text
            cantidad(2) = txbCantidad3.Text
            contador += 1
        End If

        If Not String.IsNullOrEmpty(txbDescripcion4.Text) Then
            descripcionArreglo(3) = txbDescripcion4.Text
            precioArreglo(3) = txbPrecio4.Text
            importeArreglo(3) = lblImporte4.Text
            cantidad(3) = txbCantidad4.Text
            contador += 1
        End If

        If Not String.IsNullOrEmpty(txbDescripcion5.Text) Then
            descripcionArreglo(4) = txbDescripcion5.Text
            precioArreglo(4) = txbPrecio5.Text
            importeArreglo(4) = lblImporte5.Text
            cantidad(4) = txbCantidad5.Text
            contador += 1
        End If

        If Not String.IsNullOrEmpty(txbDescripcion6.Text) Then
            descripcionArreglo(5) = txbDescripcion6.Text()
            precioArreglo(5) = txbPrecio6.Text
            importeArreglo(5) = lblImporte6.Text
            cantidad(5) = txbCantidad6.Text
            contador += 1
        End If

        If Not String.IsNullOrEmpty(txbDescripcion7.Text) Then
            descripcionArreglo(6) = txbDescripcion7.Text
            precioArreglo(6) = txbPrecio7.Text
            importeArreglo(6) = lblImporte7.Text
            cantidad(6) = txbCantidad7.Text
            contador += 1
        End If

        If Not String.IsNullOrEmpty(txbDescripcion8.Text) Then
            descripcionArreglo(7) = txbDescripcion8.Text
            precioArreglo(7) = txbPrecio8.Text
            importeArreglo(7) = lblImporte8.Text
            cantidad(7) = txbCantidad8.Text
            contador += 1
        End If

        If Not String.IsNullOrEmpty(txbDescripcion9.Text) Then
            descripcionArreglo(8) = txbDescripcion9.Text
            precioArreglo(8) = txbPrecio9.Text
            importeArreglo(8) = lblImporte9.Text
            cantidad(8) = txbCantidad9.Text
            contador += 1
        End If

        If Not String.IsNullOrEmpty(txbDescripcion10.Text) Then
            descripcionArreglo(9) = txbDescripcion10.Text
            precioArreglo(9) = txbPrecio10.Text
            importeArreglo(9) = lblImporte10.Text
            cantidad(9) = txbCantidad10.Text
            contador += 1
        End If

        If Not String.IsNullOrEmpty(txbDescripcion11.Text) Then
            descripcionArreglo(10) = txbDescripcion11.Text
            precioArreglo(10) = txbPrecio11.Text
            importeArreglo(10) = lblImporte11.Text
            cantidad(10) = txbCantidad11.Text
            contador += 1
        End If

        If Not String.IsNullOrEmpty(txbDescripcion12.Text) Then
            descripcionArreglo(11) = txbDescripcion12.Text
            precioArreglo(11) = txbPrecio12.Text
            importeArreglo(11) = lblImporte12.Text
            cantidad(11) = txbCantidad12.Text
            contador += 1
        End If
        If Not String.IsNullOrEmpty(txbDescripcion13.Text) Then
            descripcionArreglo(12) = txbDescripcion13.Text
            precioArreglo(12) = txbPrecio13.Text
            importeArreglo(12) = lblImporte13.Text
            cantidad(12) = txbCantidad13.Text
            contador += 1
        End If

        If Not String.IsNullOrEmpty(txbDescripcion14.Text) Then
            descripcionArreglo(13) = txbDescripcion14.Text
            precioArreglo(13) = txbPrecio14.Text
            importeArreglo(13) = lblImporte14.Text
            cantidad(13) = txbCantidad14.Text
            contador += 1
        End If
        If Not String.IsNullOrEmpty(txbDescripcion15.Text) Then
            descripcionArreglo(14) = txbDescripcion15.Text
            precioArreglo(14) = txbPrecio15.Text
            importeArreglo(14) = lblImporte15.Text
            cantidad(14) = txbCantidad15.Text
            contador += 1
        End If

        Dim conceptos(contador - 1) As ComprobanteConcepto

        For i = 0 To contador - 1 Step 1
            'Concepto 1'
            conceptos(i) = New ComprobanteConcepto
            conceptos(i).cantidad = cantidad(i)
            conceptos(i).unidad = "No Aplica"
            conceptos(i).descripcion = descripcionArreglo(i)
            conceptos(i).valorUnitario = precioArreglo(i)
            conceptos(i).importe = importeArreglo(i)
        Next


        'Llena datos del receptor
        comprobante.Receptor = New ComprobanteReceptor
        comprobante.Receptor.rfc = datos.rfc
        comprobante.Receptor.nombre = datos.razon_social

        comprobante.Receptor.Domicilio = New t_Ubicacion
        comprobante.Receptor.Domicilio.calle = datos.calle
        comprobante.Receptor.Domicilio.codigoPostal = datos.c_postal
        comprobante.Receptor.Domicilio.colonia = datos.colonia
        comprobante.Receptor.Domicilio.estado = datos.estado
        comprobante.Receptor.Domicilio.municipio = datos.municipio
        comprobante.Receptor.Domicilio.noExterior = datos.noExterior
        comprobante.Receptor.Domicilio.pais = datos.pais

        comprobante.Conceptos = conceptos

        Dim exito = False

        Dim retencionIva As Decimal = lblRetencion.Text
        'Dim retencionIva As Decimal = txtRetencion.Text
        Dim iva As Decimal = lblIva.Text
        comprobante.Conceptos = conceptos

        'Llenamos impuestos'
        Dim impuestosTrasladados(0) As ComprobanteImpuestosTraslado
        impuestosTrasladados(0) = New ComprobanteImpuestosTraslado
        impuestosTrasladados(0).importe = iva
        impuestosTrasladados(0).impuesto = ComprobanteImpuestosTrasladoImpuesto.IVA
        impuestosTrasladados(0).tasa = 16

        'Agregamos impuestos'
        comprobante.Impuestos = New ComprobanteImpuestos
        comprobante.Impuestos.Traslados = impuestosTrasladados


        Dim impuestosRetenidos(0) As ComprobanteImpuestosRetencion
        impuestosRetenidos(0) = New ComprobanteImpuestosRetencion
        impuestosRetenidos(0).impuesto = ComprobanteImpuestosRetencionImpuesto.IVA
        impuestosRetenidos(0).importe = retencionIva
        comprobante.Impuestos.Retenciones = impuestosRetenidos

        Return comprobante

    End Function

    Public Sub asignarImporteConLetra(ByVal total As Decimal, ByVal facturadaEnDolares As Boolean)
        Dim cantidadEnLetra = StrConv(Letras(String.Format("{0:f2}", total), facturadaEnDolares), VbStrConv.Uppercase)
        txbCantidadLetra.Text = cantidadEnLetra
    End Sub

    Public Function regresarCantidadDeConseptos() As Integer

        Dim resultado = 0

        If Not String.IsNullOrEmpty(txbCantidad1.Text) Then
            resultado += 1
        End If

        If Not String.IsNullOrEmpty(txbCantidad2.Text) Then
            resultado += 1
        End If

        If Not String.IsNullOrEmpty(txbCantidad3.Text) Then
            resultado += 1
        End If

        If Not String.IsNullOrEmpty(txbCantidad4.Text) Then
            resultado += 1
        End If

        If Not String.IsNullOrEmpty(txbCantidad5.Text) Then
            resultado += 1
        End If

        If Not String.IsNullOrEmpty(txbCantidad6.Text) Then
            resultado += 1
        End If

        If Not String.IsNullOrEmpty(txbCantidad7.Text) Then
            resultado += 1
        End If

        If Not String.IsNullOrEmpty(txbCantidad8.Text) Then
            resultado += 1
        End If

        If Not String.IsNullOrEmpty(txbCantidad9.Text) Then
            resultado += 1
        End If

        If Not String.IsNullOrEmpty(txbCantidad10.Text) Then
            resultado += 1
        End If

        If Not String.IsNullOrEmpty(txbCantidad11.Text) Then
            resultado += 1
        End If

        If Not String.IsNullOrEmpty(txbCantidad12.Text) Then
            resultado += 1
        End If
        If Not String.IsNullOrEmpty(txbCantidad13.Text) Then
            resultado += 1
        End If
        If Not String.IsNullOrEmpty(txbCantidad14.Text) Then
            resultado += 1
        End If
        If Not String.IsNullOrEmpty(txbCantidad15.Text) Then
            resultado += 1
        End If
        Return resultado
    End Function

    'Public Function timbrarCFDI(ByVal comprobante As Comprobante) As String
    '    'Este ejemplo está dirigido a aquellos integradores que aún no generan el xml (CFDI)

    '    Dim resultado = String.Empty

    '    'Establecemos las credenciales para el permiso de conexión
    '    'Ambiente de pruebas = mvpNUXmQfK8=
    '    'Ambiente de producción = Esta será asignado por el proveedor al salir a productivo
    '    Dim modoProduccion = True
    '    Dim credenciales = "jsy+7kNPsnOotlnstxiE6w=="

    '    If comprobante.Emisor.rfc = "AAA010101AAA" Then
    '        modoProduccion = False
    '        credenciales = "mvpNUXmQfK8="
    '    End If
    '    'Inicializamos el conector' el parámetro indica el ambiente en el que se utilizará 
    '    'Fasle = Ambiente de pruebas
    '    'True = Ambiente de producción
    '    Dim conector As New Conector(modoProduccion)
    '    conector.EstableceCredenciales(credenciales)
    '    'Timbramos el CFDI por medio del conector y guardamos resultado'
    '    Dim resultadoTimbre As ResultadoTimbre
    '    resultadoTimbre = conector.TimbraCFDI(comprobante)

    '    'Verificamos el resultado
    '    If (resultadoTimbre.Exitoso) Then


    '        'Guardamos xml cfdi
    '        If (resultadoTimbre.GuardaXml(Server.MapPath("~/Contabilidad/Facturar/xmls"), String.Format("{0}-{1}", comprobante.serie, comprobante.folio))) Then
    '            lblMensajeCFDI.Text = "El xml fue guardado correctamente."

    '            '1.- Código bidimensional
    '            If (resultadoTimbre.GuardaCodigoBidimensional(Server.MapPath("~/Contabilidad/Facturar/codigos"), String.Format("{0}-{1}", comprobante.serie, comprobante.folio))) Then
    '                lblMensajeCBB.Text = "El código bidimensional fue guardado correctamente."

    '                If generarPdf(comprobante, resultadoTimbre) Then
    '                    '2.- Folio fiscal
    '                    Dim foliFiscal As String = resultadoTimbre.FolioUUID

    '                    resultado = foliFiscal
    '                Else
    '                    lblMensajeCBB.Text = "Ocurrió un error al guardar el pdf."
    '                End If
    '            Else
    '                lblMensajeCFDI.Text = "Ocurrió un error al guardar el Codigo Bidimensional."
    '            End If
    '        Else
    '            lblMensajeCFDI.Text = "Ocurrió un error al guardar el xml."
    '        End If
    '        'Los siguientes datos deberán ir en la respresentación impresa ó PDF
    '    Else
    '        lblMensajeCFDI.Text = String.Format("Error: {0}", resultadoTimbre.Descripcion)
    '    End If
    '    Return resultado
    'End Function
    Public Function timbrarCFDI(ByVal comprobante As Comprobante) As String
        Dim resultado = String.Empty

        Dim modoProduccion = True
        If comprobante.Emisor.rfc = "AAA010101AAA" Then
            modoProduccion = False
        End If
        'Fasle = Ambiente de pruebas
        'True = Ambiente de producción

        Dim conector As New TSE.Timbrado.Conector(modoProduccion)

        'Timbramos el CFDI por medio del conector y guardamos resultado'
        Dim resultadoTimbre As TSE.Timbrado.ResultadoTimbre = conector.TimbrarCFDI(comprobante)

        'Verificamos el resultado
        If (resultadoTimbre.Exitoso) Then

            'Guardamos xml cfdi
            If (resultadoTimbre.GuardaXml(Server.MapPath("~/Contabilidad/Facturar/xmls"), String.Format("{0}-{1}", comprobante.serie, comprobante.folio))) Then
                lblMensajeCFDI.Text = "El xml fue guardado correctamente."

                '1.- Código bidimensional
                If (resultadoTimbre.GuardaCodigoBidimensional(Server.MapPath("~/Contabilidad/Facturar/codigos"), String.Format("{0}-{1}", comprobante.serie, comprobante.folio))) Then
                    lblMensajeCBB.Text = "El código bidimensional fue guardado correctamente."

                    If generarPdf(comprobante, resultadoTimbre) Then
                        '2.- Folio fiscal
                        Dim foliFiscal As String = resultadoTimbre.FolioUUID

                        resultado = foliFiscal
                    Else
                        lblMensajeCBB.Text = "Ocurrió un error al guardar el pdf."
                    End If
                Else
                    lblMensajeCFDI.Text = "Ocurrió un error al guardar el Codigo Bidimensional."
                End If
            Else
                lblMensajeCFDI.Text = "Ocurrió un error al guardar el xml."
            End If
            'Los siguientes datos deberán ir en la respresentación impresa ó PDF
        Else
            lblMensajeCFDI.Text = String.Format("Error: {0}", resultadoTimbre.Descripcion)
        End If
        Return resultado
    End Function
    Public Sub asignarIvaTraslado(ByVal tasa As Decimal)
        txbTasaIva.Text = tasa
    End Sub
    Public Sub asignarIvaRetenido(ByVal tasa As Decimal)
        txbTasaRetencion.Text = tasa
    End Sub
    Public Function regresarTasaIvaTraslado() As Decimal
        Return txbTasaIva.Text
    End Function
    Public Function regresarTasaIvaRetenido() As Decimal
        Return txbTasaRetencion.Text
    End Function

    'Public Function generarPdf(ByVal comprobante As Comprobante,
    '                      ByVal ResultadoTimbre As ResultadoTimbre)
    Public Function generarPdf(ByVal comprobante As Comprobante,
                          ByVal ResultadoTimbre As TSE.Timbrado.ResultadoTimbre)
        'Manual http://www.4guysfromrolla.com/articles/030911-1.aspx
        'Codigo de ejemplo http://www.4guysfromrolla.com/code/PdfCreate.pdf

        Dim itemsTable As String = String.Empty
        Dim subtotal As Decimal = 0.0

        Dim exito = True

        Dim iva = 0.0F
        Dim retencion = 0.0F
        Dim total = 0.0F

        Dim document = New Document(PageSize.LETTER, 15, 15, 15, 15)

        Try
            PdfWriter.GetInstance(document, New FileStream(Server.MapPath(String.Format("~/contabilidad/facturar/pdfs/{0}-{1}.pdf", comprobante.serie, comprobante.folio)), FileMode.Create))
            document.Open()

            'Ejemplo para agregar tablas'
            'Dim tablaTimbrado As Table = New Table(2)
            'tablaTimbrado.AddCell("CANTIDAD")
            'tablaTimbrado.AddCell("UNIDAD DE MEDIDA")
            'tablaTimbrado.AddCell("DESCRIPCIÓN")
            'tablaTimbrado.AddCell("PRECIO UNITARIO")
            'tablaTimbrado.AddCell("IMPORTE")

            itemsTable = "<TABLE><TR><TH>CANTIDAD</TH> <TH>UNIDAD DE MEDIDA</TH> <th>DESCRIPCIÓN</TH> <TH>PRECIO UNITARIO</TH> <TH>IMPORTE</TH> </TR>"
            For Each Concepto In comprobante.Conceptos

                'Dim cellCantidad As Cell = New Cell(Concepto.cantidad.ToString())
                'cellCantidad.SetWidth("10")
                'tablaTimbrado.AddCell(cellCantidad)

                'Dim cellUnidad As Cell = New Cell(Concepto.unidad)
                'cellUnidad.SetWidth("10")
                'tablaTimbrado.AddCell(cellUnidad)

                'Dim cellDescripcion As Cell = New Cell(Concepto.descripcion)
                'cellDescripcion.SetWidth("10")
                'tablaTimbrado.AddCell(cellDescripcion)

                'Dim cellPUnitario As Cell = New Cell(Concepto.valorUnitario.ToString())
                'cellPUnitario.SetWidth("10")
                'tablaTimbrado.AddCell(cellPUnitario)

                'Dim cellImporte As Cell = New Cell(Concepto.importe.ToString())
                'cellImporte.SetWidth("10")
                'tablaTimbrado.AddCell(cellImporte)

                itemsTable += String.Format("<TR><TD width='10'>{0}</TD><TD width='10'>{1}</TD><TD width='100'>{2}</TD><TD>{3:c2}</TD><TD width='15'>{4:c2}</TD></TR>", Concepto.cantidad, Concepto.unidad, Concepto.descripcion, Concepto.valorUnitario, Concepto.importe)

            Next
            subtotal = lblSubtotal.Text

            iva = lblIva.Text

            retencion = lblRetencion.Text
            'retencion = txtRetencion.Text

            total = lblTotal.Text

            itemsTable += String.Format("<TR><TD></TD><TD></TD><TD></TD><TD><strong>Subtotal</strong></TD><TD><strong>{0:c2}</strong></TD></TR>", subtotal)
            itemsTable += String.Format("<TR><TD></TD><TD></TD><TD></TD><TD><strong>IVA</strong></TD><TD><strong>{0:c2}</strong></TD></TR>", iva)
            itemsTable += String.Format("<TR><TD></TD><TD></TD><TD></TD><TD><strong>Retención</strong></TD><TD><strong>{0:c2}</strong></TD></TR>", retencion)
            itemsTable += String.Format("<TR><TD></TD><TD></TD><TD></TD><TD><strong>Total</strong></TD><TD><strong>{0:c2}</strong></TD></TR>", total)
            itemsTable += "</TABLE>"
            itemsTable += "</br>COMENTARIOS:<br>" + txbAnotaciones.Text + ""

            'Contenido
            'Dim parrafo = New Paragraph("Hola")
            'document.Add(parrafo)
            Dim logo = iTextSharp.text.Image.GetInstance(Server.MapPath(("~/Imagenes/logoFactura.jpg")))
            'logo.SetAbsolutePosition(380, 690)
            logo.Alignment = Image.TEXTWRAP
            logo.IndentationRight = 30.0F
            document.Add(logo)

            Dim contents As String = File.ReadAllText(Server.MapPath("~/contabilidad/facturar/factura.htm"))
            contents = contents.Replace("[TipoComprobante]", ddlTipoComprobante.SelectedItem.Text)
            contents = contents.Replace("[folio]", comprobante.folio)
            contents = contents.Replace("[serie]", comprobante.serie)
            contents = contents.Replace("[folioFiscal]", ResultadoTimbre.FolioUUID)
            contents = contents.Replace("[certificado]", ResultadoTimbre.No_Certificado)
            contents = contents.Replace("[lugar]", String.Format("{0},{1},{2}.", comprobante.Emisor.DomicilioFiscal.pais, comprobante.Emisor.DomicilioFiscal.estado, comprobante.Emisor.DomicilioFiscal.municipio))
            contents = contents.Replace("[fechaEmision]", comprobante.fecha)
            contents = contents.Replace("[regimen]", comprobante.Emisor.RegimenFiscal(0).Regimen)

            contents = contents.Replace("[emisorNombre]", comprobante.Emisor.nombre)
            Dim direccionEmisor = String.Format("{0} No.{1}, {2}. {3}, {4}", Comprobante.Emisor.DomicilioFiscal.calle, Comprobante.Emisor.DomicilioFiscal.noExterior, Comprobante.Emisor.DomicilioFiscal.colonia, Comprobante.Emisor.DomicilioFiscal.municipio, Comprobante.Emisor.DomicilioFiscal.estado)
            contents = contents.Replace("[emisorDireccion]", direccionEmisor)
            contents = contents.Replace("[emisorCp]", comprobante.Emisor.DomicilioFiscal.codigoPostal)
            contents = contents.Replace("[paginaWeb]", "tse.com.mx")
            contents = contents.Replace("[rfcEmisor]", comprobante.Emisor.rfc)

            contents = contents.Replace("[nombreReceptor]", comprobante.Receptor.nombre)
            contents = contents.Replace("[rfcReceptor]", comprobante.Receptor.rfc)
            Dim direccionReceptor = String.Format("{0} No. {1}, {2}. {3}, {4}. {5}", Comprobante.Receptor.Domicilio.calle, Comprobante.Receptor.Domicilio.noExterior, Comprobante.Receptor.Domicilio.colonia, Comprobante.Receptor.Domicilio.municipio, Comprobante.Receptor.Domicilio.estado, Comprobante.Receptor.Domicilio.codigoPostal)
            contents = contents.Replace("[domicilioReceptor]", direccionReceptor)

            Dim facturadaEnDolares = False
            If comprobante.Moneda = "Dolares" Then
                facturadaEnDolares = True
            End If

            Dim cantidadEnLetra = StrConv(Letras(String.Format("{0:f2}", Comprobante.total), facturadaEnDolares), VbStrConv.Uppercase)

            'document.Add(tablaTimbrado)
            Dim cantidad = String.Empty
            contents = contents.Replace("[ITEMS]", itemsTable)
            contents = contents.Replace("[cantidadEnLetra]", cantidadEnLetra)
            contents = contents.Replace("[formaDePago]", comprobante.formaDePago)
            contents = contents.Replace("[metodoDePago]", comprobante.metodoDePago)

            If Not String.IsNullOrEmpty(comprobante.NumCtaPago) Then
                contents = contents.Replace("[ctaDePago]", String.Format("No.Cta. Pago: {0}", comprobante.NumCtaPago))
            Else
                contents = contents.Replace("[ctaDePago]", "No. Cta. Pago: No Identificado")
            End If

            Dim colorVerde = New Color(0, 66, 0)
            Dim sizeFont = 7.0F
            Dim titleFont = FontFactory.GetFont("Arial", sizeFont, Font.BOLDITALIC, colorVerde)
            Dim paraghapFont = FontFactory.GetFont("Arial", sizeFont, Color.BLACK)


            Dim e1 As New Chunk("Sello Digital del CFDI:" + vbNewLine, titleFont)
            Dim e2 As New Chunk(String.Format("{0}{1}", ResultadoTimbre.SelloCFDI, vbNewLine), paraghapFont)
            Dim e3 As New Chunk("Sello del SAT:" + vbNewLine, titleFont)
            Dim e4 As New Chunk(String.Format("{0}{1}", ResultadoTimbre.SelloSAT, vbNewLine), paraghapFont)
            Dim parrafo As New Paragraph()
            parrafo.Add(e1)
            parrafo.Add(e2)
            parrafo.Add(e3)
            parrafo.Add(e4)

            Dim e5 As New Chunk("Cadena original del complemento de certificación digital del SAT:" + vbNewLine, titleFont)
            Dim e6 As New Chunk(String.Format("{0}{1}", ResultadoTimbre.CadenaTimbre, vbNewLine), paraghapFont)
            Dim e7 As New Chunk("No. de Serie del Certificado del SAT:" + vbNewLine, titleFont)
            Dim e8 As New Chunk(String.Format("{0}{1}", ResultadoTimbre.SelloSAT, vbNewLine), paraghapFont)
            Dim e9 As New Chunk("Fecha y Hora de Certificación:" + vbNewLine, titleFont)
            Dim e10 As New Chunk(String.Format("{0}{1}", ResultadoTimbre.FechaCertificacion, vbNewLine), paraghapFont)
            Dim e11 As New Chunk("Este documento es una representación impresa de un CFDI", paraghapFont)
            Dim parrafo2 As New Paragraph()
            parrafo2.Add(e5)
            parrafo2.Add(e6)
            parrafo2.Add(e7)
            parrafo2.Add(e8)
            parrafo2.Add(e9)
            parrafo2.Add(e10)
            parrafo2.Add(e11)

            Dim parsedHtmlElements = HTMLWorker.ParseToList(New StringReader(contents), Nothing)

            For Each htmlElement In parsedHtmlElements
                document.Add(htmlElement)
            Next

            Dim codigo = iTextSharp.text.Image.GetInstance(Server.MapPath(String.Format("~/contabilidad/facturar/codigos/{0}-{1}.jpg", Comprobante.serie, Comprobante.folio)))
            codigo.ScalePercent(50, 50)
            codigo.Alignment = Image.TEXTWRAP ''Insertar imagen con texto
            codigo.SpacingAfter = 15.0F
            codigo.IndentationRight = 30.0F
            document.Add(codigo)
            document.Add(parrafo)
            document.Add(parrafo2)
            document.Close()

            'Para abrir el pdf en una ventana nueva
            'Response.ContentType = "application/pdf"
            'Response.AddHeader("Content-Disposition", String.Format("attachment;filename=Receipt-{0}.pdf", "Orden"))
            'Response.BinaryWrite(output.ToArray())
        Catch ex As Exception
            lblMensajePdf.Text = String.Format("Ocurrio un problema al guardar el archivo pdf.{0}", ex.Message)
            Return False
        Finally
            document.Close()
        End Try
        Return exito
    End Function

    'Protected Sub btnActualizaRetencion_Click(sender As Object, e As EventArgs) Handles btnActualizaRetencion.Click
    '    calcularTotal(txtRetencion.Text.Replace("$", ""))
    'End Sub
End Class