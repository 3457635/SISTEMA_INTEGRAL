Imports System.IO
Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration
Public Class Trafico
    Inherits System.Web.UI.Page
    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DataSourceConnectionString1").ConnectionString)
    Dim cmd As SqlCommand = Nothing
    Dim Dpto As String = "Trafico"
    Dim dr As SqlDataReader = Nothing
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (IsPostBack = False) Then
            GridDisplayFiles()
        End If
    End Sub
    Sub GridDisplayFiles()
        con.Open()
        cmd = New SqlCommand("Select Fecha, Depto as Encargado, Nombre from Archivos where Depto='" + Dpto + "'", con)
        dr = cmd.ExecuteReader()
        If (dr.HasRows) Then
            GridView2.DataSource = dr
            GridView2.DataBind()
        Else
            Label1.Text = "No hay archivos cargados"
        End If

    End Sub
    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim bandera As Boolean = False
        If (FileUpload1.HasFile) Then
            Dim nombre As String = FileUpload1.PostedFile.FileName
            Dim extension As String = Path.GetExtension(nombre)
            Dim flag As Integer = 0

            con.Open()
            cmd = New SqlCommand("Select count(*) from Archivos where nombre='" + nombre + "' and Depto='" + Dpto + "'", con)
            If (cmd.ExecuteNonQuery() = 0) Then
                Label1.Text = "Ya existe un archivo con este nombre"
            Else
                con.Close()
                Select Case (extension.ToLower)
                    Case ".docx"
                        flag = 1
                        Exit Select
                    Case ".pdf"
                        flag = 1
                        Exit Select
                    Case ".doc"
                        flag = 1
                        Exit Select
                    Case ".xlsx"
                        flag = 1
                        Exit Select
                    Case ".xls"
                        flag = 1
                        Exit Select
                End Select
                If flag = 1 Then
                    FileUpload1.SaveAs(Server.MapPath("~/Reportes_Abiertos/Trafico/" + nombre))
                    cmd = New SqlCommand("INSERT INTO dbo.Archivos ([Nombre],[Depto],[fecha])" & _
                                         "Values ('" + nombre + "', '" + Dpto + "', '" + Date.Now + "')", con)
                    con.Open()
                    If (cmd.ExecuteNonQuery() <> 0) Then
                        Label1.Text = "ARCHIVO CARGADO CORRECTAMENTE"
                        Label1.ForeColor = System.Drawing.Color.Green

                        con.Close()
                        GridDisplayFiles()

                    Else
                        Label1.Text = "FALLA AL CARGAR EL ARCHIVO"
                    End If
                Else
                    Label1.Text = "SOLO SE ADMITEN DOCUMENTOS TIPO PDF, WORD Y EXCEL"
                End If
            End If
        End If



    End Sub


End Class