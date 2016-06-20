Imports System.Data.SqlClient
Public Class ConexionSQL
    Private connection As SqlConnection

    Sub New()

        Dim cadena As String = "Data Source=rtbygfdtxb.database.windows.net,1433;Initial Catalog=tse_erp;User Id=omarifr; Password=Ifrramo2."
        '/* Para trabajar con el servidor SQLExpress de la maquina */
        '//string DtsConection = "Data Source=.\SQLEXPRESS;Initial Catalog=NOMBRE_BD; " + "Integrated Security=True;";
        '/* Para trabajar con Archivo de BD (.mdf), si que este montado en SQLExpress */
        '//DtsConection = “Server=.\SQLExpress;AttachDbFilename=C:\Direccion\NOMBRE.mdf; Database=NOMBRE;
        '//Trusted_Connection=true;
        '/* Para trabajar con un servidor remoto Ya sea una Base de datos Remota o en Caso de WEB SITE cuando la pongamos en el Host */
        '/* Necesitamos la IP del Servidor de BD, el puerto generalmente es 1533, Usuario y Password lo proporciona el Hostring */
        '//DtsConection = “Data Source=72.17.135.40,1533; Database=NOMBRE_BD; User ID=USUARIO; Password=PASSWORD;”;
        connection = New SqlConnection(cadena)
    End Sub

    Public Sub Abrir()

        connection.Open()
    End Sub

    Public Sub Cerrar()

        connection.Close()
    End Sub
    '/// <summary>
    '/// Query en Datatable
    '/// </summary>
    '/// <param name="Comando"></param>
    '/// <param name="Tabla"></param>
    '/// <returns></returns>
    Public Function getDataQuery(ByVal Comando As String, ByRef Tabla As DataTable) As DataTable

        Me.Abrir()
        Dim CMD As SqlDataAdapter = New SqlDataAdapter(Comando, connection)

        CMD.Fill(Tabla)
        Return Tabla

    End Function

    '/// <summary>
    '/// Query en Dataset
    '/// </summary>
    '/// <param name="Comando"></param>
    '/// <param name="Tabla"></param>
    '/// <returns></returns>
    Public Function getDataQuery(ByVal Comando As String, ByRef Tabla As DataSet) As DataSet

        Me.Abrir()
        Dim CMD As SqlDataAdapter = New SqlDataAdapter(Comando, connection)


        CMD.Fill(Tabla)
        Return Tabla
    End Function
    'Function RunQuery(ByVal sqlQuery As String, ByVal param As Dictionary(Of String, Object)) As DataSet
    '    Dim resultsDataSet As DataSet = New DataSet
    '    Using cmd As SqlCommand = New SqlCommand()
    '        cmd.CommandText = sqlQuery
    '        cmd.Connection = connection
    '        Using cmd.Connection

    '            Using dataAdapter As SqlDataAdapter = New SqlDataAdapter(cmd)
    '                If Not param.Count = 0 Then
    '                    For i As Integer = 0 To param.Count - 1
    '                        cmd.Parameters.Add(
    '                      New SqlParameter(param.ElementAt(i).Key, param.ElementAt(i).Value))
    '                    Next
    '                End If
    '                dataAdapter.Fill(resultsDataSet)
    '                cmd.Connection.Close()

    '                cmd.Parameters.Clear()
    '            End Using
    '        End Using
    '    End Using
    '    Return resultsDataSet
    'End Function
    Function RunQuery(ByVal sqlQuery As String, ByVal param As Dictionary(Of String, Object)) As DataTable
        Dim resultsDataSet As DataTable = New DataTable
        Using cmd As SqlCommand = New SqlCommand()
            cmd.CommandText = sqlQuery
            cmd.Connection = connection
            Using cmd.Connection

                Using dataAdapter As SqlDataAdapter = New SqlDataAdapter(cmd)
                    If Not param.Count = 0 Then
                        For i As Integer = 0 To param.Count - 1
                            cmd.Parameters.Add(
                          New SqlParameter(param.ElementAt(i).Key, param.ElementAt(i).Value))
                        Next
                    End If
                    dataAdapter.Fill(resultsDataSet)
                    cmd.Connection.Close()

                    cmd.Parameters.Clear()
                End Using
            End Using
        End Using
        Return resultsDataSet
    End Function
    Public Sub ejecutarProcedimientoDS(ByVal nombreProc As String, ByVal param As Dictionary(Of String, String), ByRef dataset As DataSet)
        Using cmd As SqlCommand = New SqlCommand()

            cmd.CommandText = nombreProc
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = connection
            Using cmd.Connection

                Using dataAdapter As SqlDataAdapter = New SqlDataAdapter(cmd)

                    For i As Integer = 0 To param.Count - 1
                        cmd.Parameters.Add(
                      New SqlParameter(param.ElementAt(i).Key, param.ElementAt(i).Value))
                    Next

                    dataAdapter.Fill(dataset)
                    cmd.Connection.Close()

                    cmd.Parameters.Clear()
                End Using
            End Using
        End Using
    End Sub
    Public Sub ejecutarProcedimientoDT(ByVal nombreProc As String, ByVal param As Dictionary(Of String, Object), ByRef datatable As DataTable)
        Using cmd As SqlCommand = New SqlCommand()

            cmd.CommandText = nombreProc
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = connection
            Using cmd.Connection

                Using dataAdapter As SqlDataAdapter = New SqlDataAdapter(cmd)


                    For i As Integer = 0 To param.Count - 1

                        cmd.Parameters.Add(
                      New SqlParameter(param.ElementAt(i).Key, param.ElementAt(i).Value))
                    Next

                    dataAdapter.Fill(datatable)
                    cmd.Connection.Close()

                    cmd.Parameters.Clear()
                End Using
            End Using
        End Using
    End Sub

End Class
