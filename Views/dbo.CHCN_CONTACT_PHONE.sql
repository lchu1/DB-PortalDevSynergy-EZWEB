SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[CHCN_CONTACT_PHONE]
AS
SELECT Portal_DNN7.dbo.UserProfile.UserID, Portal_DNN7.dbo.Users.Username, Portal_DNN7.dbo.ProfilePropertyDefinition.PropertyCategory, 
                  Portal_DNN7.dbo.UserProfile.PropertyValue AS UserPhoneNO, Portal_DNN7.dbo.ProfilePropertyDefinition.PropertyName
FROM     Portal_DNN7.dbo.UserProfile INNER JOIN
                  Portal_DNN7.dbo.Users ON Portal_DNN7.dbo.UserProfile.UserID = Portal_DNN7.dbo.Users.UserID INNER JOIN
                  Portal_DNN7.dbo.ProfilePropertyDefinition ON Portal_DNN7.dbo.UserProfile.PropertyDefinitionID = Portal_DNN7.dbo.ProfilePropertyDefinition.PropertyDefinitionID
WHERE  (Portal_DNN7.dbo.ProfilePropertyDefinition.PropertyName = N'telephone')

GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[17] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "UserProfile (Portal_DNN7.dbo)"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 168
               Right = 280
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users (Portal_DNN7.dbo)"
            Begin Extent = 
               Top = 7
               Left = 328
               Bottom = 168
               Right = 588
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProfilePropertyDefinition (Portal_DNN7.dbo)"
            Begin Extent = 
               Top = 7
               Left = 636
               Bottom = 168
               Right = 878
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 2520
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3516
         Alias = 2928
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'CHCN_CONTACT_PHONE', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'CHCN_CONTACT_PHONE', NULL, NULL
GO
