Imports Telerik.Web.UI

Public Class AppointmentInfo
        Private _id As String
        Private _subject As String
        Private _start As DateTime
        Private _end As DateTime
        Private _recurrenceRule As String
        Private _recurrenceParentId As String

        Public ReadOnly Property ID() As String
            Get
                Return _id
            End Get
        End Property

        Public Property Subject() As String
            Get
                Return _subject
            End Get
            Set(ByVal value As String)
                _subject = value
            End Set
        End Property

        Public Property Start() As DateTime
            Get
                Return _start
            End Get
            Set(ByVal value As DateTime)
                _start = value
            End Set
        End Property

        Public Property [End]() As DateTime
            Get
                Return _end
            End Get
            Set(ByVal value As DateTime)
                _end = value
            End Set
        End Property

        Public Property RecurrenceRule() As String
            Get
                Return _recurrenceRule
            End Get
            Set(ByVal value As String)
                _recurrenceRule = value
            End Set
        End Property

        Public Property RecurrenceParentID() As String
            Get
                Return _recurrenceParentId
            End Get
            Set(ByVal value As String)
                _recurrenceParentId = value
            End Set
        End Property


        Private Sub New()
            Me._id = Guid.NewGuid().ToString()
        End Sub

        Public Sub New(ByVal subject As String, ByVal start As DateTime, ByVal [end] As DateTime, ByVal recurrenceRule As String, ByVal recurrenceParentID As String)
            Me.New()
            Me._subject = subject
            Me._start = start
            Me._end = [end]
            Me._recurrenceRule = recurrenceRule
            Me._recurrenceParentId = recurrenceParentID
        End Sub

        Public Sub New(ByVal source As Appointment)
            Me.New()
            CopyInfo(source)
        End Sub

        Public Sub CopyInfo(ByVal source As Appointment)
            Subject = source.Subject
            Start = source.Start
            [End] = source.[End]
            RecurrenceRule = source.RecurrenceRule
            If source.RecurrenceParentID IsNot Nothing Then
                RecurrenceParentID = source.RecurrenceParentID.ToString()
            End If
        End Sub
    End Class
