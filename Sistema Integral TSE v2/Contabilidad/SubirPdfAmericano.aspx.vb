Imports System.IO
Imports System.Web.HttpPostedFile
Public Class SubirPdfAmericano
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim filePaths() As String = Directory.GetFiles(Server.MapPath("~/Contabilidad/Facturar/pdfAmericano//"))
            Dim files As List(Of ListItem) = New List(Of ListItem)
            For Each filePath As String In filePaths
                files.Add(New ListItem(Path.GetFileName(filePath), filePath))
            Next
            GridView2.DataSource = files
            GridView2.DataBind()
        End If
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles btnSubir.Click
        


        If fileUFacturaAmericana.HasFile Then
            ' Get the size in bytes of the file to upload.
            Dim filesize As Integer = fileUFacturaAmericana.PostedFile.ContentLength
            ' Allow only files less than 2,100,000 bytes (approximately 2 MB) to be uploaded.
            If filesize <= 2100000 Then
                Dim extension As String = System.IO.Path.GetExtension(fileUFacturaAmericana.FileName)
                If extension.ToLower() = ".pdf" Then
                    Dim fileName As String = Path.GetFileName(fileUFacturaAmericana.PostedFile.FileName)
                    fileUFacturaAmericana.PostedFile.SaveAs((Server.MapPath("~/Contabilidad/Facturar/pdfAmericano/") + fileName))
                    lblMensaje.Text = "La factura se ha subido correctamente"
                    Response.Redirect(Request.Url.AbsoluteUri)
                Else
                    lblMensaje.Text = "Esto no es un PDF por favor verifica tu archivo"
                End If

            Else
                lblMensaje.Text = "Archivo muy grande"
            End If
        Else
            lblMensaje.Text = "No seleccionaste ningun archivo"
        End If
        

    End Sub
    Protected Sub descargaPDF(ByVal sender As Object, ByVal e As EventArgs)
        Dim filePath As String = CType(sender, LinkButton).CommandArgument
        Response.ContentType = ContentType
        Response.AppendHeader("Content-Disposition", ("attachment; filename=" + Path.GetFileName(filePath)))
        Response.WriteFile(filePath)
        Response.End()
    End Sub
End Class