GaragePreviewCoords = {}

GaragePreviewCoords.Garages = {
    ['pc'] = {
        ped = vector4(233.14, -776.330, 29.715, 121.88), 
        vehicle = vector4(235.66, -777.692, 30.69, 85.0), 
        cam = vector3(231.153, -778.863, 30.695)
    },
    ['pillbox'] = {
        ped = vector4(-308.875, -889.859, 30.066, 121.88),
        vehicle = vector4(-306.355, -891.219, 31.066, 85.0),
        cam = vector3(-310.872, -892.389, 31.071)
    },
    ['paleto'] = {
        ped = vector4(-194.558, 6223.517, 30.487, 119.055),
        vehicle = vector4(-193.078, 6221.157, 31.487, 85.0),
        cam = vector3(-198.071, 6221.987, 31.492)
    },
    ['sandyshores'] = {
        ped = vector4(1634.598, 3565.200, 34.262, 121.88),
        vehicle = vector4(1637.118, 3563.840, 35.262, 85.0),
        cam = vector3(1632.601, 3562.670, 35.267)
    }
}

GaragePreviewCoords.Pounds = {
    ['hayes'] = {
        ped = vector4(479.908, -1318.404, 28.196, 289.134),
        vehicle = vector4(477.850555, -1315.859375, 29.195557, 274.96063),
        cam = vector3(482.895, -1317.934, 29.201)
    },
    ['paleto'] = {
        ped = vector4(-466.444, 6027.969, 30.336, 269.055),
        vehicle = vector4(-467.010986, 6030.342773, 31.335571, 240.944885),
        cam = vector3(-463.447, 6027.439, 32.0)
    },
    ['sandy-shores'] = {
        ped = vector4(1850.466, 3714.725, 32.088, 121.88),
        vehicle = vector4(1852.986, 3713.365, 33.088, 85.0),
        cam = vector3(1848.479, 3712.195, 33.093)
    }
}

function GaragePreviewCoords:GetPreviewCoords(garageName, isPound)
    if isPound then
        return self.Pounds[garageName] or self.Pounds['hayes']
    else
        return self.Garages[garageName] or self.Garages['pc']
    end
end

