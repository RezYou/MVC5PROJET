CREATE TABLE [dbo].[Categorie] (
    [IDcategorie] int  NOT NULL,
    [CategorieName] varchar(50)  NOT NULL
);
GO

-- Creating table 'Client'

-- Creating table 'Commande'
CREATE TABLE [dbo].[Commande] (
    [NumCmd] int IDENTITY(1,1) NOT NULL,
    [DateCmd] datetime  NOT NULL,
    [dateLiv] datetime  NOT NULL,
    [statusPai] varchar(50)  NOT NULL
);
GO

-- Creating table 'Comments'
CREATE TABLE [dbo].[Comments] (
    [IDcmnt] int IDENTITY(1,1) NOT NULL,
    [Comment] varchar(100)  NOT NULL,
    [IDP] int  NOT NULL
);
GO

-- Creating table 'LigneCommande'
CREATE TABLE [dbo].[LigneCommande] (
    [NumCmd] int  NOT NULL,
    [NumClt] int  NOT NULL,
    [Qte] int  NOT NULL,
    [IDP] int  NOT NULL
);
GO

-- Creating table 'Produit'
CREATE TABLE [dbo].[Produit] (
    [IDP] int  NOT NULL,
    [Nom] varchar(100)  NOT NULL,
    [Description] varchar(600)  NOT NULL,
    [Prix] float  NOT NULL,
    [IDcategorie] int  NOT NULL,
    [IDProfile] int  NOT NULL,
    [QteStock] int  NOT NULL,
    [IDlivrer] int  NOT NULL,
    [FeedBack] int  NOT NULL
);
GO

-- Creating table 'ProfileBuyer'
CREATE TABLE [dbo].[ProfileBuyer] (
    [IDProfile] int IDENTITY(1,1) NOT NULL,
    [NumClt] int  NOT NULL,
    [IDCom] int  NULL
);
GO

-- Creating table 'profileImages'
CREATE TABLE [dbo].[profileImages] (
    [IDimages] int IDENTITY(1,1) NOT NULL,
    [Logo] varbinary(max)  NOT NULL,
    [CovertureImage] varbinary(max)  NOT NULL,
    [SlideImage1] varbinary(max)  NOT NULL,
    [SlideImage2] varbinary(max)  NULL,
    [SlideImage3] varbinary(max)  NULL
);
GO

-- Creating table 'ProfileSeller'
CREATE TABLE [dbo].[ProfileSeller] (
    [IDProfile] int IDENTITY(1,1) NOT NULL,
    [NumClt] int  NOT NULL,
    [color] varchar(50)  NULL,
    [IDimages] int  NULL
);
GO

-- Creating primary key on [IDcategorie] in table 'Categorie'
ALTER TABLE [dbo].[Categorie]
ADD CONSTRAINT [PK_Categorie]
    PRIMARY KEY CLUSTERED ([IDcategorie] ASC);
GO



-- Creating primary key on [NumCmd] in table 'Commande'
ALTER TABLE [dbo].[Commande]
ADD CONSTRAINT [PK_Commande]
    PRIMARY KEY CLUSTERED ([NumCmd] ASC);
GO

-- Creating primary key on [IDcmnt] in table 'Comments'
ALTER TABLE [dbo].[Comments]
ADD CONSTRAINT [PK_Comments]
    PRIMARY KEY CLUSTERED ([IDcmnt] ASC);
GO

-- Creating primary key on [NumCmd], [NumClt], [IDP] in table 'LigneCommande'
ALTER TABLE [dbo].[LigneCommande]
ADD CONSTRAINT [PK_LigneCommande]
    PRIMARY KEY CLUSTERED ([NumCmd], [NumClt], [IDP] ASC);
GO

-- Creating primary key on [IDP] in table 'Produit'
ALTER TABLE [dbo].[Produit]
ADD CONSTRAINT [PK_Produit]
    PRIMARY KEY CLUSTERED ([IDP] ASC);
GO

-- Creating primary key on [IDProfile] in table 'ProfileBuyer'
ALTER TABLE [dbo].[ProfileBuyer]
ADD CONSTRAINT [PK_ProfileBuyer]
    PRIMARY KEY CLUSTERED ([IDProfile] ASC);
GO

-- Creating primary key on [IDimages] in table 'profileImages'
ALTER TABLE [dbo].[profileImages]
ADD CONSTRAINT [PK_profileImages]
    PRIMARY KEY CLUSTERED ([IDimages] ASC);
GO

-- Creating primary key on [IDProfile] in table 'ProfileSeller'
ALTER TABLE [dbo].[ProfileSeller]
ADD CONSTRAINT [PK_ProfileSeller]
    PRIMARY KEY CLUSTERED ([IDProfile] ASC);
GO
ALTER TABLE [dbo].[Produit]
ADD CONSTRAINT [FK_Produit_Categorie]
    FOREIGN KEY ([IDcategorie])
    REFERENCES [dbo].[Categorie]
        ([IDcategorie])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Produit_Categorie'
CREATE INDEX [IX_FK_Produit_Categorie]
ON [dbo].[Produit]
    ([IDcategorie]);
GO




-- Creating foreign key on [NumCmd] in table 'LigneCommande'
ALTER TABLE [dbo].[LigneCommande]
ADD CONSTRAINT [FK_LigneCommande_Commande]
    FOREIGN KEY ([NumCmd])
    REFERENCES [dbo].[Commande]
        ([NumCmd])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating foreign key on [IDCom] in table 'ProfileBuyer'
ALTER TABLE [dbo].[ProfileBuyer]
ADD CONSTRAINT [FK_ProfileBuyer_Commande]
    FOREIGN KEY ([IDCom])
    REFERENCES [dbo].[Commande]
        ([NumCmd])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProfileBuyer_Commande'
CREATE INDEX [IX_FK_ProfileBuyer_Commande]
ON [dbo].[ProfileBuyer]
    ([IDCom]);
GO

-- Creating foreign key on [IDP] in table 'Comments'
ALTER TABLE [dbo].[Comments]
ADD CONSTRAINT [FK_Comments_Produit]
    FOREIGN KEY ([IDP])
    REFERENCES [dbo].[Produit]
        ([IDP])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Comments_Produit'
CREATE INDEX [IX_FK_Comments_Produit]
ON [dbo].[Comments]
    ([IDP]);
GO

-- Creating foreign key on [IDP] in table 'LigneCommande'
ALTER TABLE [dbo].[LigneCommande]
ADD CONSTRAINT [FK_LigneCommande_Produit]
    FOREIGN KEY ([IDP])
    REFERENCES [dbo].[Produit]
        ([IDP])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_LigneCommande_Produit'
CREATE INDEX [IX_FK_LigneCommande_Produit]
ON [dbo].[LigneCommande]
    ([IDP]);
GO

-- Creating foreign key on [IDProfile] in table 'Produit'
ALTER TABLE [dbo].[Produit]
ADD CONSTRAINT [FK_Produit_ProfileSeller]
    FOREIGN KEY ([IDProfile])
    REFERENCES [dbo].[ProfileSeller]
        ([IDProfile])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Produit_ProfileSeller'
CREATE INDEX [IX_FK_Produit_ProfileSeller]
ON [dbo].[Produit]
    ([IDProfile]);
GO

-- Creating foreign key on [IDimages] in table 'ProfileSeller'
ALTER TABLE [dbo].[ProfileSeller]
ADD CONSTRAINT [FK_ProfileSeller_profileImages]
    FOREIGN KEY ([IDimages])
    REFERENCES [dbo].[profileImages]
        ([IDimages])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProfileSeller_profileImages'
CREATE INDEX [IX_FK_ProfileSeller_profileImages]
ON [dbo].[ProfileSeller]
    ([IDimages]);
GO