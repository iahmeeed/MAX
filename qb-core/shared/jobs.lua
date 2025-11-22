QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
    ['unemployed'] = {
        label = 'Civilian',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 10
            },
        },
    },
    ['admin'] = {
        label = 'Admin',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'admin',
                payment = 10
            },
        },
    },
    ['mechanic'] = {
        label = 'Mechanic',
        type = "mechanic",
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
            ['1'] = {
                name = 'Novice',
                payment = 75
            },
            ['2'] = {
                name = 'Experienced',
                payment = 100
            },
            ['3'] = {
                name = 'Advanced',
                payment = 125
            },
            ['4'] = {
                name = 'Manager',
                isboss = true,
                isowner = true,
                payment = 150
            },
        },
    },
    ['lsc'] = {
    label = 'Los Santos Customs',
    defaultDuty = false,
    offDutyPay = false,
    grades = {
        ['0'] = {
            name = 'Trainee',
            payment = 300
        },
        ['1'] = {
            name = 'Mechanic',
            payment = 500
        },
        ['2'] = {
            name = 'Senior Mechanic',
            payment = 700
        },
        ['3'] = {
            name = 'Manager',
            payment = 900,
            isboss = true
        },
        ['4'] = {
            name = 'CEO',
            payment = 1200,
            isboss = true
        },
    }
},
    ['weazel'] = {
        label = 'Weazel',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Training',
                payment = 400
            },
            ['1'] = {
                name = 'Media ',
                payment = 600
            },
            ['2'] = {
                name = 'Featured MEDIA',
                payment = 800
            },
            ['3'] = {
                name = 'Responsible',
                isboss = true,
                payment = 1000
            },
            ['4'] = {
                name = 'manager',
                isboss = true,
                payment = 1200
            },
            ['5'] = {
                name = 'Executive manager',
                isboss = true,
                payment = 1500
            },
        },
    },
    ['cia'] = {
        label = 'CIA',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Agent',
                payment = 50
            },
            ['1'] = {
                name = 'Leader ',
                payment = 100
            },
            ['2'] = {
                name = 'Director',
                payment = 200
            },
        },
    },
    ['marines'] = {
        label = 'Marines',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Private',
                payment = 50
            },
            ['1'] = {
                name = 'Corporal',
                payment = 100
            },
            ['2'] = {
                name = 'Sergeant',
                payment = 150
            },
            ['3'] = {
                name = 'Major',
                payment = 200
            },
            ['4'] = {
                name = 'General',
                payment = 250
            },
        },
    },
    ['police'] = {
        label = 'Law Enforcement',
        type = "leo",
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = "Cadet",
                payment = 50
            },
            ['1'] = {
                name = "Solo Cadet",
                payment = 100
            },
            ['2'] = {
                name = "Officer One",
                payment = 150
            },
            ['3'] = {
                name = "Officer Two ",
                payment = 200
            },
            ['4'] = {
                name = "Officer Three",
                payment = 250
            },
            ['5'] = {
                name = "Senior Officer",
                payment = 300
            },
            ['6'] = {
                name = "Sergeant",
                payment = 350
            },
            ['7'] = {
                name = "First Sergeant",
                payment = 400
            },
            ['8'] = {
                name = "Staff Sergeant",
                payment = 450
            },
            ['9'] = {
                name = "Lieutenant",
                payment = 500
            },
            ['10'] = {
                name = "First Lieutenant",
                payment = 550
            },
            ['11'] = {
                name = "Captain",
                payment = 600
            },
            ['12'] = {
                name = "Major",
                payment = 650
            },
            ['13'] = {
                name = "Colonel",
                payment = 700
            },
            ['14'] = {
                name = "Lieutenant General",
                payment = 750
            },
            ['15'] = {
                name = "Major General",
                payment = 800
            },
            ['16'] = {
                name = "General",
                isboss = true,
                payment = 850
            },
            ['17'] = {
                name = "Assistant of Police Chief",
                isboss = true,
                payment = 1000
            },
            ['18'] = {
                name = "Chief of Police",
                isboss = true,
                payment = 1050
            },
            ['19'] = {
                name = "Deputy Minister of Interior",
                isboss = true,
                payment = 1100
            },
            ['20'] = {
                name = "Minister of interior",
                isboss = true,
                payment = 1200
            },
        },
    },
    ['mafia'] = {
        label = 'Mafia',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = "Associate",
                payment = 100
            },
            ['1'] = {
                name = "Soldier",
                payment = 200
            },
            ['2'] = {
                name = "Underboss",
                payment = 300
            },
            ['3'] = {
                name = "Boss",
                isboss = true,
                payment = 400
            },
            ['4'] = {
                name = "Godfather",
                isboss = true,
                payment = 500
            },
        },
    },
    ['ambulance'] = {
        label = 'EMS',
        type = 'ems',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Student',
                payment = 400
            },
            ['1'] = {
                name = 'EMR',
                payment = 450
            },
            ['2'] = {
                name = 'EMT',
                payment = 500
            },
            ['3'] = {
                name = 'AEMT',
                payment = 550
            },
            ['4'] = {
                name = 'Paramedic',
                payment = 600
            },
            ['5'] = {
                name = 'Advanced Paramedic',
                payment = 650
            },
            ['6'] = {
                name = 'Paramedic 2',
                payment = 700
            },
            ['7'] = {
                name = 'Trainee Doctor',
                payment = 500
            },
            ['8'] = {
                name = 'Resident Doctor',
                payment = 600
            },
            ['9'] = {
                name = 'Specialist Doctor',
                payment = 700
            },
            ['10'] = {
                name = 'Consultant Doctor',
                payment = 900
            },
            ['11'] = {
                name = 'Deputy Manager',
                isboss = true,
                payment = 1100
            },
            ['12'] = {
                name = 'Manager',
                isboss = true,
                payment = 1300
            },
        },
    },
    ['realestate'] = {
        label = 'Real Estate',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
            ['1'] = {
                name = 'House Sales',
                payment = 75
            },
            ['2'] = {
                name = 'Business Sales',
                payment = 100
            },
            ['3'] = {
                name = 'Broker',
                payment = 125
            },
            ['4'] = {
                name = 'Manager',
                isboss = true,
                payment = 150
            },
        },
    },
    ['taxi'] = {
        label = 'Taxi',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
            ['1'] = {
                name = 'Driver',
                payment = 75
            },
            ['2'] = {
                name = 'Event Driver',
                payment = 100
            },
            ['3'] = {
                name = 'Sales',
                payment = 125
            },
            ['4'] = {
                name = 'Manager',
                isboss = true,
                payment = 150
            },
        },
    },
    ['bus'] = {
        label = 'Bus',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
    },
    ['law'] = {
        label = 'Law Firm',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['1'] = {
                name = 'lawyer',
                payment = 100
            },
            ['2'] = {
                name = 'Deputy Head Of DOJ',
                payment = 300
            },
            ['3'] = {
                name = 'Head Of DOJ',
                payment = 400
            },
        },
    },
    ['judge'] = {
        label = 'Honorary',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Judge',
                payment = 100
            },
        },
    },
    ['lawyer'] = {
        label = 'Law Firm',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Associate',
                payment = 50
            },
        },
    },
    ['reporter'] = {
        label = 'Reporter',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Journalist',
                payment = 50
            },
        },
    },
    ['trucker'] = {
        label = 'Trucker',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
    },
    ['tow'] = {
        label = 'Towing',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
    },
    ['garbage'] = {
        label = 'Garbage',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Collector',
                payment = 50
            },
        },
    },
    ['vineyard'] = {
        label = 'Vineyard',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Picker',
                payment = 50
            },
        },
    },
    ['luxury'] = {
        label = 'luxury',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'luxury',
                payment = 100
            },
        },
    },
    ['casino'] = {
        label = 'Casino',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 500
            },
            ['1'] = {
                name = 'Novice',
                payment = 700
            },
            ['2'] = {
                name = 'Experienced',
                payment = 1100
            },
            ['3'] = {
                name = 'Advanced',
                payment = 1500
            },
            ['4'] = {
                name = 'Manager',
                isboss = true,
                payment = 2000
            },
        },
    },
}
