Public Class ctlNuevaLista
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext
    Dim listaCorreos As String 'variable creada 17 06 2015

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txbIdEmpresa.Text = Session("idEmpresa")
        txbIdRuta.Text = Session("idRuta")
        Dim idEmpresa = txbIdEmpresa.Text
        Dim idRuta = txbIdRuta.Text

        txbCorreos.Text = obtenerContactosSeguimiento(idEmpresa, idRuta)
        listaCorreos = txbCorreos.Text '17 06 2015

    End Sub
    'Metodo creado para generar listas y guardar los correos 17 06 2015 ----------------------------------------
    Private Sub guardarCorreos()
        Dim idEmpresa = txbIdEmpresa.Text
        Dim nombreLista = Now.AddHours(-7).ToString()
        Dim idRuta = txbIdRuta.Text
        Dim idLista = txbIdLista.Text
        Dim separators() As String = {",", "!", "?", ";", ":", " "}
        Dim listaCorreos2 = txbCorreos.Text

        lblMensaje.Text = String.Empty
        'Quitamos comas y espacios a la lsita de correos y los asignamos a un array
        Dim correosArray As String() = listaCorreos2.Split(separators, StringSplitOptions.RemoveEmptyEntries)

        Dim mailsNoValidos = String.Empty

        Dim nuevaLista As New listaDistribucion With {.nombreLista = nombreLista, .idStatus = 5}

        For Each correo In correosArray
            Dim mailValido = validar_Mail(correo)
            'System.Diagnostics.Debug.WriteLine(String.Format("correo:{0} valido:{1}", mailValido.ToString, correo.ToString))

            If Not mailValido Then
                mailsNoValidos += correo + " "
            Else
                Dim nuevoCorreo As New correo With {.correo = correo, .listaDistribucion = nuevaLista}
                db.correos.InsertOnSubmit(nuevoCorreo)
            End If
        Next

        Dim buscarServicios = From consulta In db.precios
                             Where consulta.id_empresa = idEmpresa And
                             consulta.id_ruta = idRuta And
                             consulta.id_status = 5
                             Select consulta.id_relacion

        For Each service In buscarServicios
            Dim idRelacion = service

            If IsNumeric(idRelacion) Then
                Dim nuevoAsignacion As New contactosServicio With {.id_relacion = idRelacion, .listaDistribucion = nuevaLista}
                db.contactosServicios.InsertOnSubmit(nuevoAsignacion)
            End If
        Next

        If Not String.IsNullOrEmpty(mailsNoValidos) Then
            lblMensaje.Text = String.Format("Estas cuentas no cumplen con la sintaxis de un email:{0}  ", mailsNoValidos)
        Else
            db.SubmitChanges()
            lblMensaje.Text = "Listo!"
        End If
    End Sub
    '---------------------------------------------------------------------------------------------------------------------------
    'Evento mejorado que le permite a Guillermo eliminar los correos que no necesite 17 06 2015
    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click

        Dim nombreLista = Now.AddHours(-7).ToString()
        Dim idEmpresa = txbIdEmpresa.Text
        Dim idRuta = txbIdRuta.Text
        Dim idLista = txbIdLista.Text

        listaCorreos = txbCorreos.Text

        Dim separators() As String = {",", "!", "?", ";", ":", " "}
        'Si no hay ninguno guardado y  si escribio correos  
        If String.IsNullOrEmpty(obtenerContactosSeguimiento(idEmpresa, idRuta)) And Not String.IsNullOrEmpty(listaCorreos) Then
            guardarCorreos()
            'Si escribio nuevos correos o borro y si habia contactos guardados
        ElseIf Not String.IsNullOrEmpty(listaCorreos) And Not String.IsNullOrEmpty(obtenerContactosSeguimiento(idEmpresa, idRuta)) Then
            Dim arrayId() As String = obteneridLista(idEmpresa, idRuta)
            For Each elemento In arrayId
                Dim buscarLista = (From consulta In db.listaDistribucions
                              Where consulta.idLista = elemento
                              Select consulta).FirstOrDefault()

                If Not buscarLista Is Nothing Then
                    db.listaDistribucions.DeleteOnSubmit(buscarLista)
                End If
            Next
            db.SubmitChanges() 'borra la lista anterior
            'Si dejo en blanco los correos significa que no se guardara nada
            If Not String.IsNullOrWhiteSpace(listaCorreos) Then
                guardarCorreos() 'crea una nueva y guarda los correos
            End If



        End If
        'Codigo que estaba antes-------------------------------------------
        ' Dim nombreLista = Now.ToString()
        '  Dim idEmpresa = txbIdEmpresa.Text
        '  Dim idRuta = txbIdRuta.Text
        ' Dim idLista = txbIdLista.Text

        '  Dim listaCorreos = txbCorreos.Text

        '' Dim separators() As String = {",", "!", "?", ";", ":", " "}

        '  If Not String.IsNullOrEmpty(txbIdLista.Text) Then
        'Dim buscarLista = (From consulta In db.listaDistribucions
        'Where consulta.idLista = idLista
        '                 Select consulta).FirstOrDefault()
        '
        ' If Not buscarLista Is Nothing Then
        'db.listaDistribucions.DeleteOnSubmit(buscarLista)
        ' End If

        ' End If

        ' lblMensaje.Text = String.Empty
        'Quitamos comas y espacios a la lsita de correos y los asignamos a un array
        ' Dim correosArray As String() = listaCorreos.Split(separators, StringSplitOptions.RemoveEmptyEntries)

        ' Dim mailsNoValidos = String.Empty


        '  Dim nuevaLista As New listaDistribucion With {.nombreLista = nombreLista, .idStatus = 5}


        '  For Each correo In correosArray
        'Dim mailValido = validar_Mail(correo)
        'System.Diagnostics.Debug.WriteLine(String.Format("correo:{0} valido:{1}", mailValido.ToString, correo.ToString))

        '' If Not mailValido Then
        'mailsNoValidos += correo + " "
        ' Else
        '  Dim nuevoCorreo As New correo With {.correo = correo, .listaDistribucion = nuevaLista}
        '  db.correos.InsertOnSubmit(nuevoCorreo)
        ' End If
        ' Next

        ' Dim buscarServicios = From consulta In db.precios
        'Where consulta.id_empresa = idEmpresa And
        ' consulta.id_ruta = idRuta And
        ' consulta.id_status = 5
        '                     Select consulta.id_relacion
        '
        '' For Each service In buscarServicios
        'Dim idRelacion = service
        '
        '  If IsNumeric(idRelacion) Then
        'Dim nuevoAsignacion As New contactosServicio With {.id_relacion = idRelacion, .listaDistribucion = nuevaLista}
        '  db.contactosServicios.InsertOnSubmit(nuevoAsignacion)
        ' End If
        ' Next


        ' If Not String.IsNullOrEmpty(mailsNoValidos) Then
        '  lblMensaje.Text = String.Format("Estas cuentas no cumplen con la sintaxis de un email:{0}  ", mailsNoValidos)
        ' Else
        ' db.SubmitChanges()
        '  lblMensaje.Text = "Listo!"
        '  End If

    End Sub

   
End Class