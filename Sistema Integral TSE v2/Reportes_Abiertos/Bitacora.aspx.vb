Imports System.IO
Imports System.Web.HttpPostedFile
Imports System.Data.SqlClient
Public Class Bitacora1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim filePaths() As String = Directory.GetFiles(Server.MapPath("~/Reportes_Abiertos/BitacoraSemanal/"))
            Dim files As List(Of ListItem) = New List(Of ListItem)
            For Each filePath As String In filePaths
                files.Add(New ListItem(Path.GetFileName(filePath), filePath))
            Next
            GridView2.DataSource = files
            GridView2.DataBind()

        End If
    End Sub
    Sub poblarArbol(ByVal node As TreeNode)
        Dim param As Dictionary(Of String, Object) = New Dictionary(Of String, Object)
        Dim con As New ConexionSQL()
        con.Abrir()
        Dim resultSet As New DataTable
        resultSet = con.RunQuery("Select nombre_area from documentacion_areas where nivel = 2", param)
        con.Cerrar()
        If resultSet.Rows.Count > 0 Then
            Dim row As DataRow
            For Each row In resultSet.Rows
                Dim NewNode As TreeNode = New  _
                    TreeNode(row("nombre_area").ToString())
                NewNode.PopulateOnDemand = True
                NewNode.SelectAction = TreeNodeSelectAction.Expand
                node.ChildNodes.Add(NewNode)
            Next
        End If
    End Sub
    Sub poblarNodos(ByVal node As TreeNode)
        Dim param As Dictionary(Of String, Object) = New Dictionary(Of String, Object)
        param.Add("@idarea", 3)
        Dim con As New ConexionSQL()
        con.Abrir()
        Dim resultSet As New DataTable
        resultSet = con.RunQuery("Select nombre_doc from documentacion_areas where pertenece_a_nivel = @idarea", param)

        con.Cerrar()
        If resultSet.Rows.Count > 0 Then
            Dim row As DataRow
            For Each row In resultSet.Rows

                Dim NewNode As TreeNode = New  _
                    TreeNode(row("nombre_doc").ToString())
                NewNode.PopulateOnDemand = False
                NewNode.SelectAction = TreeNodeSelectAction.Expand
                node.ChildNodes.Add(NewNode)
            Next
        End If
    End Sub

    Protected Sub btnSubir_Click(sender As Object, e As EventArgs) Handles btnSubir.Click


        Dim area As String = rbAreas.SelectedValue

        If fileUDocumentos.HasFile Then
            ' Get the size in bytes of the file to upload.
            Dim filesize As Integer = fileUDocumentos.PostedFile.ContentLength
            'System.IO.Path.GetDirectoryName(saveFileDialog1.FileName)
            Dim str As Stream = fileUDocumentos.PostedFile.InputStream
            Dim br As New BinaryReader(str)
            Dim bytes As Byte() = br.ReadBytes(str.Length)

            ' Allow only files less than 2,100,000 bytes (approximately 2 MB) to be uploaded.
            If filesize <= 12100000 Then
                Dim extension As String = System.IO.Path.GetExtension(fileUDocumentos.FileName)
                If (extension.ToLower() = ".pdf" Or extension.ToLower() = ".docx") Then
                    Dim fileName As String = Path.GetFileName(fileUDocumentos.PostedFile.FileName)
                    Dim ruta As String = Server.MapPath("~/Reportes_Abiertos/BitacoraSemanal/") + fileName
                    fileUDocumentos.PostedFile.SaveAs(ruta)
                    lblMensaje.Text = "Documento guardado"
                    Response.Redirect(Request.Url.AbsoluteUri)
                Else
                    lblMensaje.Text = "Esto no es un archivo permitido por favor verificalo"
                End If

            Else
                lblMensaje.Text = "Archivo muy grande"
            End If
        Else
            lblMensaje.Text = "No seleccionaste ningun archivo"
        End If



    End Sub
    Protected Sub descargaArchivo(ByVal sender As Object, ByVal e As EventArgs)
        Dim filePath As String = CType(sender, LinkButton).CommandArgument
        Response.ContentType = ContentType
        Response.AppendHeader("Content-Disposition", ("attachment; filename=" + Path.GetFileName(filePath)))
        Response.WriteFile(filePath)
        Response.End()
    End Sub

 

    Protected Sub DropDownList1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        Dim filePaths() As String = Directory.GetFiles(Server.MapPath("~/Reportes_Abiertos/BitacoraSemanal/" + DropDownList1.SelectedValue + "/"))
        Dim files As List(Of ListItem) = New List(Of ListItem)
        For Each filePath As String In filePaths
            files.Add(New ListItem(Path.GetFileName(filePath), filePath))
        Next
        GridView2.DataSource = files
        GridView2.DataBind()
    End Sub
End Class