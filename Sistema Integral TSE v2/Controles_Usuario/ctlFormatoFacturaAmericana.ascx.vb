Public Class ctlFormatoFacturaAmericana
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Public Sub datosReceptor(ByVal empresa As String, ByVal direccion As String, ByVal ciudad As String, ByVal telefono As String)
        txbName.Text = empresa
        txbDireccion.Text = direccion
        txbCiudad.Text = ciudad
        txbTelefono.Text = telefono

    End Sub
    Public Sub ponerCantidadConLetra(ByVal cantidad As String)
        txbCantidadLetra.Text = cantidad
    End Sub
    Public Function obtenerFolio()

        Dim result = 0
        Dim ultimoFolio = (From consulta In db.facturas
                        Where consulta.facturaAmericana = True
                        Select consulta
                        Order By consulta.folio Descending).FirstOrDefault()

        If Not ultimoFolio Is Nothing Then
            lblFolio.Text = ultimoFolio.folio + 1
            result = ultimoFolio.folio + 1
        End If
        Return result
    End Function


    Public Sub limpiarFormulario()
        limpiar_formulario(Me)
    End Sub

    Public Function regresarCantidad(ByVal linea)
        Dim result = 0
        Dim cantidad = String.Empty
        Select Case linea
            Case Is = 1
                cantidad = txbCantidad1.Text
            Case Is = 2
                cantidad = txbCantidad2.Text
            Case 3
                cantidad = txbCantidad3.Text
            Case 4
                cantidad = txbCantidad4.Text
            Case 5
                cantidad = txbCantidad5.Text
            Case 6
                cantidad = txbCantidad6.Text
            Case 7
                cantidad = txbCantidad7.Text
            Case 8
                cantidad = txbCantidad8.Text

        End Select

        If IsNumeric(cantidad) Then
            result = cantidad
        End If

        Return result

    End Function
    Public Sub cambiarCantidadEnLinea(ByVal linea As Integer, ByVal cantidad As Integer)
        Select Case linea
            Case Is = 1
                txbCantidad1.Text = cantidad
            Case Is = 2
                txbCantidad2.Text = cantidad
            Case 3
                txbCantidad3.Text = cantidad
            Case 4
                txbCantidad4.Text = cantidad
            Case 5
                txbCantidad5.Text = cantidad
            Case 6
                txbCantidad6.Text = cantidad
            Case 7
                txbCantidad7.Text = cantidad
            Case 8
                txbCantidad8.Text = cantidad
        End Select
    End Sub
    Public Sub cambiarImporteEnLinea(ByVal linea As Integer, ByVal importe As Decimal)
        Select Case linea
            Case Is = 1
                importe1.Text = String.Format("{0:c}", importe)
            Case Is = 2
                importe2.Text = String.Format("{0:c}", importe)
            Case 3
                importe3.Text = String.Format("{0:c}", importe)
            Case 4
                importe4.Text = String.Format("{0:c}", importe)
            Case 5
                importe5.Text = String.Format("{0:c}", importe)
            Case 6
                importe6.Text = String.Format("{0:c}", importe)
            Case 7
                importe7.Text = String.Format("{0:c}", importe)
            Case 8
                importe8.Text = String.Format("{0:c}", importe)
        End Select
    End Sub
    Public Function obtenertotal()
        Dim total = 0.0
        If IsNumeric(importe1.Text) Then
            total = importe1.Text
        End If

        If IsNumeric(importe2.Text) Then
            total += importe2.Text
        End If

        If IsNumeric(importe3.Text) Then
            total += importe3.Text
        End If

        If IsNumeric(importe4.Text) Then
            total += importe4.Text
        End If

        If IsNumeric(importe5.Text) Then
            total += importe5.Text
        End If

        If IsNumeric(importe6.Text) Then
            total += importe6.Text
        End If

        If IsNumeric(importe7.Text) Then
            total += importe7.Text
        End If

        If IsNumeric(importe8.Text) Then
            total += importe8.Text
        End If

        txbTotal.Text = String.Format("{0:c2}", total)

        Return total
    End Function
    Public Sub ponerFecha()
        lblAno.Text = Now.AddHours(-7).Year()
        lblDia.Text = Now.AddHours(-7).Day
        lblMes.Text = StrConv(Now.AddHours(-7).ToString("MMM"), VbStrConv.ProperCase)
    End Sub

    Public Sub agregarRenglon(ByVal cantidad As Integer, ByVal descripcion As String, ByVal valorUnitario As Decimal)
        If String.IsNullOrEmpty(txbDescripcion1.Text) Then
            txbCantidad1.Text = cantidad
            txbDescripcion1.Text = descripcion
            txbValor1.Text = String.Format("{0:c2}", valorUnitario)
            importe1.Text = String.Format("{0:c2}", cantidad * valorUnitario)

        ElseIf String.IsNullOrEmpty(txbDescripcion2.Text) Then
            txbCantidad2.Text = cantidad
            txbDescripcion2.Text = descripcion
            txbValor2.Text = String.Format("{0:c2}", valorUnitario)
            importe2.Text = String.Format("{0:c2}", cantidad * valorUnitario)

        else If String.IsNullOrEmpty(txbDescripcion3.Text) Then
        txbCantidad3.Text = cantidad
        txbDescripcion3.Text = descripcion
            txbValor3.Text = String.Format("{0:c2}", valorUnitario)
            importe3.Text = String.Format("{0:c2}", cantidad * valorUnitario)

        else If String.IsNullOrEmpty(txbDescripcion4.Text) Then
        txbCantidad4.Text = cantidad
        txbDescripcion4.Text = descripcion
            txbValor4.Text = String.Format("{0:c2}", valorUnitario)
            importe4.Text = String.Format("{0:c2}", cantidad * valorUnitario)

        else If String.IsNullOrEmpty(txbDescripcion5.Text) Then
        txbCantidad5.Text = cantidad
        txbDescripcion5.Text = descripcion
            txbValor5.Text = String.Format("{0:c2}", valorUnitario)
            importe5.Text = String.Format("{0:c2}", cantidad * valorUnitario)


        Else If String.IsNullOrEmpty(txbDescripcion6.Text) Then
            txbCantidad6.Text = cantidad
            txbDescripcion6.Text = descripcion
            txbValor6.Text = String.Format("{0:c2}", valorUnitario)
            importe6.Text = String.Format("{0:c2}", cantidad * valorUnitario)

        ElseIf String.IsNullOrEmpty(txbDescripcion7.Text) Then
            txbCantidad7.Text = cantidad
            txbDescripcion7.Text = descripcion
            txbValor7.Text = String.Format("{0:c2}", valorUnitario)
            importe7.Text = String.Format("{0:c2}", cantidad * valorUnitario)

        ElseIf String.IsNullOrEmpty(txbDescripcion8.Text) Then
            txbCantidad8.Text = cantidad
            txbDescripcion8.Text = descripcion
            txbValor8.Text = String.Format("{0:c2}", valorUnitario)
            importe8.Text = String.Format("{0:c2}", cantidad * valorUnitario)
        End If

    End Sub
    
End Class