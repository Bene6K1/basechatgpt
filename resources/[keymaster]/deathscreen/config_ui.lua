ConfigUI = {}

-- Activation/désactivation des éléments visuels
ConfigUI.EnableRedGradient = true  -- Fond rouge autour de l'écran
ConfigUI.EnableBackgroundFade = true -- Fond noir transparent

-- Personnalisation du fond rouge
ConfigUI.RedGradient = {
    CenterOpacity = 0.05,  -- Opacité au centre (0-1)
    EdgeOpacity = 0.4,     -- Opacité aux bords (0-1)
    InnerRGB = {200, 0, 0},  -- Couleur intérieure (R,G,B)
    OuterRGB = {140, 0, 0}   -- Couleur extérieure (R,G,B)
}

-- Personnalisation du fond général
ConfigUI.Background = {
    Opacity = 0.5,       -- Opacité du fond noir (0-1)
    RGB = {10, 10, 10}   -- Couleur de base du fond (R,G,B)
}


-- Personnalisation des boutons
ConfigUI.Buttons = {
    Background = "hsla(240, 5%, 4%, 0.705)",
    BackgroundHover = "hsla(240, 5%, 6%, 0.805)",
    TextColor = "#ffffff",
    Width = "250px",
    Padding = "12px 20px",
    Gap = "2rem" -- Espacement entre les boutons
}

-- Personnalisation de l'image skull
ConfigUI.SkullImage = {
    Enabled = true,
    Height = "150px",
    Filter = "grayscale(100%) brightness(2) opacity(0.7)", -- Filtre CSS pour l'image
    MarginBottom = "0.5rem"
}

-- Personnalisation du timer
ConfigUI.Timer = {
    FontSize = "80px",
    FontWeight = "700",
    Color = "#ffffff",
    SeparatorColor = "#4fb5e9",
    SeparatorFontSize = "80px"
}

-- Animations
ConfigUI.Animations = {
    TimerAnimations = true
}

-- Textes
ConfigUI.Texts = {
    Title = "VOUS ÊTES INCONSCIENT",
    Description = "Vous êtes actuellement en état d'inconscience. En attendant l'arrivée des secours, vous pouvez appeler un médecin ou patienter jusqu'à l'unité X.",
    CallMedic = "Appeler les secours",
    Respawn = "Unité X",
    StaffRevive = "Staff Revive"
}

-- Police de caractères
ConfigUI.Font = {
    Family = "'Manrope', sans-serif",
    TitleSize = "48px",
    TitleWeight = "800",
    TitleColor = "#ffffff",
    TitleLetterSpacing = "2px",
    DescriptionSize = "16px",
    DescriptionColor = "rgba(255, 255, 255, 0.8)",
    ButtonTextSize = "14px",
    ButtonLetterSize = "14px"
}
