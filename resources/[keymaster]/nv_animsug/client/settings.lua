Settings = {}

Settings.actions = {
  idle = {
    type = TYPE_TIME,
    minimum = Config.animations.idle.minimumTime or 4,
    importance = 1,
    cancelable = true
  },
  
  intimidate = {
    type = TYPE_INTIMIDATE,
    minimum = 8,
    importance = 10,
    cancelable = false
  },
  
  showPain = {
    type = TYPE_SHOW_PAIN,
    minimum = 145,
    importance = 6,
    cancelable = false
  },
  
  sit = {
    type = TYPE_RAYCAST,
    minimum = 1,
    importance = 3,
    freeze = true,
    cancelable = true,
    raycasts = {
      {
        start = vector3(0.0, -0.5, 0.0),
        finish = vector3(0.0, -0.2, -0.6)
      }
    },
    blacklist = {
      {
        start = vector3(0.0, 0.0, 0.0),
        finish = vector3(0.0, -0.8, 0.0)
      },
      {
        start = vector3(0.0, 0.0, -0.15),
        finish = vector3(0.0, -0.7, 0.0)
      }
    },
    align = {
      start = vector3(0.0, -0.5, 0.0),
      finish = vector3(0.0, -0.2, -0.6)
    }
  },
  
  lean = {
    type = TYPE_RAYCAST,
    minimum = 2,
    importance = 4,
    cancelable = true,
    raycasts = {
      {
        start = vector3(0.0, 0.0, 0.0),
        finish = vector3(0.0, -0.8, 0.0)
      },
      {
        start = vector3(0.0, 0.0, 0.0),
        finish = vector3(0.0, -0.8, -0.9)
      }
    },
    blacklist = {},
    align = {
      start = vector3(0.0, 0.0, 0.0),
      finish = vector3(0.0, -0.8, 0.0)
    }
  },
  
  leanBar = {
    type = TYPE_RAYCAST,
    minimum = 1,
    importance = 5,
    cancelable = true,
    freeze = true,
    raycasts = {
      {
        start = vector3(0.0, 0.45, 0.15),
        finish = vector3(0.0, 0.0, -0.35)
      }
    },
    blacklist = {
      {
        start = vector3(0.0, 0.05, 0.2),
        finish = vector3(0.0, 0.5, 0.0)
      }
    },
    align = {
      start = vector3(0.0, 0.45, 0.15),
      finish = vector3(0.0, 0.0, -0.35)
    }
  },
  
  inspectCar = {
    type = TYPE_INSPECT,
    importance = 9,
    cancelable = true,
    raycast = {
      start = vector3(0.0, 0.5, 0.25),
      finish = vector3(0.0, 0.5, -0.7)
    }
  },
  
  cheerBurnout = {
    type = TYPE_CHEER_BURNOUT,
    importance = 10,
    cancelable = true,
    raycast = {
      start = vector3(0.0, 1.0, 0.8),
      finish = vector3(0.0, 15.0, 0.0),
      size = 1.4
    }
  },
  
  greet = {
    type = TYPE_GREET,
    importance = 8,
    cancelable = false,
    duration = 15,
    raycast = {
      start = vector3(0.0, 2.5, 0.5),
      finish = vector3(0.0, 8.0, 0.0),
      size = 1.0
    }
  },
  
  conversation = {
    type = TYPE_CONVERSATION,
    importance = 6,
    cancelable = true,
    duration = 15,
    raycast = {
      start = vector3(0.0, 1.0, 0.5),
      finish = vector3(0.0, 6.0, 0.0),
      size = 1.3
    }
  },
  
  [TYPE_AREA_SPECIFIC] = {
    type = TYPE_AREA_SPECIFIC,
    importance = 2,
    cancelable = true
  },
  
  [TYPE_PROP_SPECIFIC] = {
    type = TYPE_PROP_SPECIFIC,
    importance = 7,
    freeze = true,
    cancelable = true,
    raycast = {
      start = vector3(0.0, 0.0, 0.0),
      finish = vector3(0.0, 1.25, -0.5),
      size = 0.5
    }
  }
}