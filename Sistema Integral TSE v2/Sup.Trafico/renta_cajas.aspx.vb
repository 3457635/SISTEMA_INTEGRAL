Public Class renta_cajas
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lblAno.Text = Now.Year.ToString()
            Dim ultimo_folio = (From consulta In db.orden_cajas
                            Where consulta.ano = Now.Year
                            Select consulta.consecutivo).Max()

            If Not ultimo_folio Is Nothing Then
                lblConsecutivo.Text = CStr(ultimo_folio + 1)
            Else
                lblConsecutivo.Text = "1"
            End If
        End If
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        If IsNumeric(lblConsecutivo.Text) And Not String.IsNullOrEmpty(txbInicio.Text) Then
            Dim consecutivo = CInt(lblConsecutivo.Text)

            Dim fin As Date
            If String.IsNullOrEmpty(txbFin.Text) Then
                fin = System.Data.SqlTypes.SqlDateTime.Null
            Else
                fin = txbFin.Text
            End If

            Dim nueva_renta As New orden_caja With {.id_precio = ddlCliente.SelectedValue,
                                                          .id_equipo = ddlCaja.SelectedValue,
                                                          .Inicio = txbInicio.Text,
                                                          .Fin = fin,
                                                          .ano = Now.Year(),
                                                          .consecutivo = consecutivo}

            db.orden_cajas.InsertOnSubmit(nueva_renta)
            db.SubmitChanges()
            lblConsecutivo.Text = CStr(consecutivo + 1)


        End If


    End Sub
End Class