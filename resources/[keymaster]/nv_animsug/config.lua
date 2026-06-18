Config = {}
Config.debug = false
Config.keybinds = {
    play = {
        key = 'minus', -- Default keybind - After loading the script once. This keybind will be assigned to your game settings
    },
    style = {
        show = true,
        top = 'auto',
        left = 'auto',
        bottom = '16px',
        right = '16px',
        fontSize = 1.4,
        bgColor = { 194, 207, 204, 0.6 },
        textColor = { 20, 20, 20, 1 },
        keybindBgColor = { 40, 40, 40, 0.6 },
        keybindTextColor = { 255, 255, 255, 1 },
        borderRadius = 0.1,
    }
}
Config.cooldown = 1000
Config.cancelControls = {
    22, 23, 25, 263, 264,
}
Config.animLists = {
    ['sitting'] = {
        {
            dict = 'timetable@ron@ig_5_p3',
            anim = 'ig_5_p3_base',
            flag = 33,
            offset = vector3(0.0, 0.55, 0.52),
        },
        {
            dict = 'timetable@reunited@ig_10',
            anim = 'base_amanda',
            flag = 33,
            offset = vector3(0.0, 0.55, 0.52),
        },
        {
            dict = 'timetable@ron@ig_3_couch',
            anim = 'base',
            flag = 33,
            offset = vector3(0.0, 0.65, 0.52),
        },
        {
            dict = 'timetable@maid@couch@',
            anim = 'base',
            flag = 33,
            offset = vector3(0.0, 0.45, 0.65),
        },
    },
    ['dance'] = {
        {
            dict = 'anim@amb@nightclub@dancers@solomun_entourage@',
            anim = 'mi_dance_facedj_17_v1_female^1',
            flag = 33,
            offset = vector3(0.0, 0.0, 0.0),
        },
        {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@',
            anim = 'high_center',
            flag = 33,
            offset = vector3(0.0, 0.0, 0.0),
        },
        {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@',
            anim = 'high_center',
            flag = 33,
            offset = vector3(0.0, 0.0, 0.0),
        },
        {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@male@var_b@',
            anim = 'high_center_down',
            flag = 33,
            offset = vector3(0.0, 0.0, 0.0),
        },
        {
            dict = 'anim@amb@nightclub@dancers@podium_dancers@',
            anim = 'hi_dance_facedj_17_v2_male^5',
            flag = 33,
            offset = vector3(0.0, 0.0, 0.0),
        },
        {
            dict = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity',
            anim = 'hi_dance_facedj_09_v2_female^1',
            flag = 33,
            offset = vector3(0.0, 0.0, 0.0),
        },
        {
            dict = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@',
            anim = 'high_center_up',
            flag = 33,
            offset = vector3(0.0, 0.0, 0.0),
        },
    }
}
Config.propSpecific = {
    {
        label = 's\'asseoir',
        useChairSystem = true, 
        align = true,
        offset = vector3(0.0, -1.3, 0.45),
        models = {
            'prop_bench_01a',
            'prop_bench_01c',
            'prop_bench_02',
            'prop_bench_03',
            'prop_bench_04',
            'prop_bench_05',
            'prop_bench_06',
            'prop_bench_07',
            'prop_bench_08',
            'prop_bench_09',
            'prop_bench_10',
            'prop_bench_11',
        },
        animations = Config.animLists['sitting'],
    },
    {
        label = 'fouiller la poubelle',
        align = false,
        models = {
            'prop_bin_01a',
            'prop_bin_03a',
            'prop_bin_05a',
        },
        animations = {
            {
                dict = 'mini@repair',
                anim = 'fixing_a_ped',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
        },
    },
    { -- Complete example with all the options
        label = 'barbecue',
        align = false,
        models = {
            'prop_bbq_5',
        },
        animations = {
            {
                dict = 'amb@prop_human_bbq@male@idle_a',
                anim = 'idle_b',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
                event = {
                    event = 'your-event:name',
                    type = 'client', -- client or server
                    params = 'bbq-start', -- this could be a table as well. It will be sent as the first attribute of the event
                },
                tool = {
                    pos = vector3(0.0, 0.0, 0.0),
                    rot = vector3(0.0, 0.0, 0.0),
                    model = 'prop_fish_slice_01',
                    bone = 28422,
                },
            },
        },
    },
}
Config.areaSpecific = {
    { -- vanilla unicorn
        label = 'danser',
        coords = vector3(115.6, -1289.0, 28.2),
        radius = 13.0,
        animations = Config.animLists['dance'],
    },
    { -- tequilalala
        label = 'danser',
        coords = vector3(-557.65, 285.32, 82.2),
        radius = 10.0,
        animations = Config.animLists['dance'],
    },
    { -- bahamas mammas
        label = 'danser',
        coords = vector3(-1386.73, -619.17, 30.8),
        radius = 10.0,
        animations = Config.animLists['dance'],
    },
}
Config.animations = {
    lean = {
        enabled = true,
        label = 'se pencher',
        animations = {
            {
                dict = 'anim@scripted@freemode_npc@fix_agy_ig4_lamar@',
                anim = 'lean_wall_idle_01_lamar',
                flag = 33,
                offset = vector3(0.0, 0.35, 0.0),
            },
            {
                dict = 'amb@world_human_leaning@male@wall@back@foot_up@idle_a',
                anim = 'idle_a',
                flag = 33,
                offset = vector3(0.0, 0.35, 0.0),
            },
            {
                dict = 'anim@scripted@freemode_npc@fix_agy_ig4_lamar@',
                anim = 'lean_wall_idle_01_lamar',
                flag = 33,
                offset = vector3(0.0, 0.35, 0.0),
            },
            {
                dict = 'amb@world_human_leaning@female@wall@back@holding_elbow@idle_a',
                anim = 'idle_a',
                flag = 33,
                offset = vector3(0.0, 0.35, 0.0),
            }
        },
    },
    leanBar = {
        enabled = true,
        label = 'se pencher vers l\'avant',
        animations = {
            {
                dict = 'anim@amb@nightclub@lazlow@ig1_vip@',
                anim = 'clubvip_base_laz',
                flag = 33,
                offset = vector3(0.0, -0.55, 0.02),
            },
            {
                dict = 'amb@prop_human_bum_shopping_cart@male@idle_a',
                anim = 'idle_c',
                flag = 33,
                offset = vector3(0.0, -0.55, 0.02),
            },
            {
                dict = 'anim@amb@nightclub@lazlow@ig1_vip@',
                anim = 'clubvip_dlg_jimmyboston_laz',
                flag = 33,
                offset = vector3(0.0, -0.45, 0.085),
            },
        },
    },
    sit = {
        enabled = true,
        label = 's\'asseoir',
        animations = Config.animLists['sitting'],
    },
    idle = {
        enabled = true,
        label = 'se reposer',
        minimumTime = 4, -- Minimum time in seconds it'll take before the suggestion appears
        animations = {
            {
                dict = 'rcmjosh1',
                anim = 'idle',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'rcmnigel1a',
                anim = 'base',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'missbigscore2aig_3',
                anim = 'wait_for_van_c',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'amb@world_human_hang_out_street@female_arms_crossed@idle_a',
                anim = 'idle_a',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'anim@heists@heist_corona@single_team',
                anim = 'single_team_loop_boss',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
        }
    },
    intimidate = {
        enabled = true,
        label = 'intimider',
        animations = {
            {
                dict = 'anim@mp_player_intselfiethe_bird',
                anim = 'idle_a',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'anim@mp_player_intupperfinger',
                anim = 'idle_a_fp',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'mini@triathlon',
                anim = 'want_some_of_this',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'anim@mp_player_intcelebrationfemale@knuckle_crunch',
                anim = 'knuckle_crunch',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'mp_player_int_uppergrab_crotch',
                anim = 'mp_player_int_grab_crotch',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'misscommon@response',
                anim = 'bring_it_on',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'misscommon@response',
                anim = 'screw_you',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
        }
    },
    showPain = {
        enabled = true,
        label = 'montrer la douleur',
        animations = {
            {
                dict = 'anim@amb@casino@valet_scenario@pose_d@',
                anim = 'scratch_face_a_m_y_vinewood_01',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'anim@amb@machinery@lathe@',
                anim = 'scratch_amy_skater_01',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'timetable@gardener@smoking_joint',
                anim = 'idle_cough',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
        }
    },
    inspectCar = {
        enabled = true,
        label = 'inspecter le véhicule',
        animations = {
            {
                dict = 'anim@amb@carmeet@checkout_engine@male_a@base',
                anim = 'base',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'anim@amb@carmeet@checkout_engine@male_b@base',
                anim = 'base',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'anim@amb@carmeet@checkout_engine@male_c@base',
                anim = 'base',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'anim@amb@carmeet@checkout_engine@male_d@base',
                anim = 'base',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'anim@amb@carmeet@checkout_engine@male_f@base',
                anim = 'base',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'anim@amb@carmeet@checkout_engine@male_g@base',
                anim = 'base',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'anim@amb@carmeet@checkout_engine@male_h@base',
                anim = 'base',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
        },
    },
    cheerBurnout = {
        enabled = true,
        label = 'acclamer',
        animations = {
            {
                dict = 'amb@world_human_cheering@male_a',
                anim = 'base',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'anim@amb@nightclub@peds@',
                anim = 'amb_world_human_cheering_female_c',
                flag = 33,
                offset = vector3(0.0, 0.0, 0.0),
            },
        },
    },
    greet = {
        enabled = true,
        label = 'saluer',
        animations = {
            {
                dict = 'friends@frj@ig_1',
                anim = 'wave_e',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'gestures@m@standing@casual',
                anim = 'gesture_hello',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
        },
    },
    conversation = {
        enabled = true,
        label = 'parler',
        animations = {
            {
                dict = 'misscarsteal4@vendor',
                anim = 'idle_a_customer1',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'missfbi3_party_d',
                anim = 'stand_talk_loop_a_male1',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'missfbi3_party_d',
                anim = 'stand_talk_loop_a_male2',
                flag = 48,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'missfbi3_party_d',
                anim = 'stand_talk_loop_b_male2',
                flag = 49,
                offset = vector3(0.0, 0.0, 0.0),
            },
            {
                dict = 'missfbi3_party_d',
                anim = 'stand_talk_loop_b_male3',
                flag = 49,
                offset = vector3(0.0, 0.0, 0.0),
            },
        },
    },
}
