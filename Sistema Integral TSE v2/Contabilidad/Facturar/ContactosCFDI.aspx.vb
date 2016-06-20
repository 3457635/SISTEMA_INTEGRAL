
Public Class ContactosCFDI

    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim idEmpresa = ddlEmpresa.SelectedValue
        Dim correos = txbCorreos.Text

        Dim separadores() = {" ", ",", vbNewLine}

        Dim arregloCorreos() = correos.Split(separadores, StringSplitOptions.RemoveEmptyEntries)

        Dim borrarLista = From consulta In db.ContactosCFDIs
                        Where consulta.idDatoFacturacion = idEmpresa
                        Select consulta


        For Each contacto As ContactosCFDI In borrarLista
            db.ContactosCFDIs.DeleteOnSubmit(contacto)
        Next

        db.SubmitChanges()
        

        lblMailIncorrectos.Text = String.Empty

        For i = 0 To arregloCorreos.Length - 1 Step 1
            Dim mail = arregloCorreos(i)


            If validar_Mail(mail) Then
                Dim nuevoCorreo As New ContactosCFDI With {.correo = mail, .idDatoFacturacion = idEmpresa}
                db.ContactosCFDIs.InsertOnSubmit(nuevoCorreo)
                db.SubmitChanges()
            Else
                lblMailIncorrectos.Text += String.Format("{0} ", mail)
            End If
        Next
        If Not String.IsNullOrEmpty(lblMailIncorrectos.Text) Then
            Dim mails = lblMailIncorrectos.Text
            lblMailIncorrectos.Text = String.Format("Direcciones de correo incorrectas: {0}", mails)
        End If
        lblMensaje.Text = "Listo!"
    End Sub

    Protected Sub ddlEmpresa_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged
        Dim idEmpresa = ddlEmpresa.SelectedValue
        lblMensaje.Text = String.Empty
        lblMailIncorrectos.Text = String.Empty

        Dim lista = (From consulta In db.ContactosCFDIs
                  Where consulta.idDatoFacturacion = idEmpresa
                  Select consulta).ToList()

        txbCorreos.Text = String.Empty
        For Each contacto In lista
            txbCorreos.Text += String.Format("{0} {1}", contacto.correo, vbNewLine)
        Next


    End Sub
End Class