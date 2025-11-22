QBShared = QBShared or {}
QBShared.ForceCompanyDefaultDutyAtLogin = true -- true: Force duty state to companydefaultDuty | false: set duty state from database last saved
QBShared.Company = {
	['none'] = {
		label = 'No Company',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'none',
                payment = 10
            },
        },
	},
    ['bennys'] = {
        label = 'Bennys',
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
    ['ottos'] = {
        label = 'OTTOS',
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
    ['tuner'] = {
        label = 'tuner',
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
    ['carzone'] = {
        label = 'Carzone',
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
    ['strokemaster'] = {
        label = 'Stroke Master',
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
    ['hayes'] = {
        label = 'Hayes',
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
    ['classicdealer'] = {
        label = 'Classic gallery',
        type = "classicdealer",
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
            ['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
            ['2'] = {
                name = 'Business Sales',
                payment = 100
            },
            ['3'] = {
                name = 'Finance',
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
    ['speedone'] = {
        label = 'Speed One Exhibition',
        type = "speedone",
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
            ['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
            ['2'] = {
                name = 'Business Sales',
                payment = 100
            },
            ['3'] = {
                name = 'Finance',
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
    ['bikedealer'] = {
        label = 'bike Exhibition',
        type = "bikedealer",
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
            ['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
            ['2'] = {
                name = 'Business Sales',
                payment = 100
            },
            ['3'] = {
                name = 'Finance',
                isboss = true,
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
    ['truckdealer'] = {
        label = 'Truck Showroom',
        type = "truckdealer",
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
            ['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
            ['2'] = {
                name = 'Business Sales',
                payment = 100
            },
            ['3'] = {
                name = 'Finance',
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
	['luxury'] = {
		label = 'Luxury Vehicle Shop',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Sales man',
                payment = 100
            },
            ['2'] = {
                name = 'Boss',
				isboss = true,
                payment = 150
            },
            ['3'] = {
                name = 'Owner',
				isboss = true,
                isowner = true,
                payment = 200
            },
        },
	},
    ['weapon'] = {
		label = 'Weapon company',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Employed',
                payment = 100
            },
            ['2'] = {
                name = 'Boss',
                isboss = true,
                payment = 150
            },
            ['3'] = {
                name = 'Owner',
				isboss = true,
                isowner = true,
                payment = 200
            },
        },
	},
    ['atom'] = {
		label = 'Atom',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Food Maker',
                payment = 350
            },
            ['2'] = {
                name = 'Boss',
                isboss = true,
                payment = 450
            },
            ['3'] = {
                name = 'Owner',
				isboss = true,
                isowner = true,
                payment = 550
            },
        },
	},
    ['snrbuns'] = {
		label = 'snrbuns',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Food Maker',
                payment = 350
            },
            ['2'] = {
                name = 'Boss',
                isboss = true,
                payment = 450
            },
            ['3'] = {
                name = 'Owner',
				isboss = true,
                isowner = true,
                payment = 550
            },
        },
	},
    ['hornys'] = {
		label = 'Hornys',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Food Maker',
                payment = 350
            },
            ['2'] = {
                name = 'Boss',
                isboss = true,
                payment = 450
            },
            ['3'] = {
                name = 'Owner',
				isboss = true,
                isowner = true,
                payment = 550
            },
        },
	},
    ['burgershot'] = {
		label = 'Burgershot',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Food Maker',
                payment = 350
            },
            ['2'] = {
                name = 'Boss',
                isboss = true,
                payment = 450
            },
            ['3'] = {
                name = 'Owner',
				isboss = true,
                isowner = true,
                payment = 550
            },
        },
	},
    ['seafood'] = {
		label = 'Seafood',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Worker',
                payment = 550
            },
            ['2'] = {
                name = 'Vice Boss',
                isboss = true,
                payment = 750
            },
            ['3'] = {
                name = 'Owner',
				isboss = true,
                isowner = true,
                payment = 850
            },
        },
	},
    ['pizzeria'] = {
		label = 'Pizzeria',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Chief',
                payment = 350
            },
            ['2'] = {
                name = 'Manger',
                isboss = true,
                payment = 450
            },
            ['3'] = {
                name = 'Owner',
				isboss = true,
                isowner = true,
                payment = 550
            },
        },
	},
    ['uwu'] = {
		label = 'Uwu',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Cofee Maker',
                payment = 350
            },
            ['2'] = {
                name = 'Boss',
				isboss = true,
                payment = 450
            },
            ['3'] = {
                name = 'Owner',
				isboss = true,
                isowner = true,
                payment = 550
            },
        },
	},
    ['carsealer'] = {
		label = 'Vehicle Sealer',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Recruit',
                payment = 50,
            },
			['2'] = {
                name = 'Manger',
                payment = 100,
                isboss = true,
            },
			['3'] = {
                name = 'Boss',
                isowner = true,
                payment = 150,
            },
        },
	},
    ['beanmachine'] = {
		label = 'Bean Machine',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Cofee Maker',
                payment = 350
            },
            ['2'] = {
                name = 'Boss',
				isboss = true,
                payment = 450
            },
            ['3'] = {
                name = 'Owner',
				isboss = true,
                isowner = true,
                payment = 550
            },
        },
	},
}



QBShared.Company['eliteauto'] = {label = 'elite',defaultDuty = true,offDutyPay = false,grades = {['3'] = { name = 'Finance', payment = 125, isowner = true},['4'] = { name = 'Boss', payment = 150, isboss = true, isowner = true},['0'] = { name = 'Recruit', payment = 50},['1'] = { name = 'Showroom Sales', payment = 75},['2'] = { name = 'Business Sales', payment = 100},}}
QBShared.Company['exoticour'] = {label = 'exotic',defaultDuty = true,offDutyPay = false,grades = {['3'] = { name = 'Finance', payment = 125, isowner = true},['4'] = { name = 'Boss', payment = 150, isboss = true, isowner = true},['0'] = { name = 'Recruit', payment = 50},['1'] = { name = 'Showroom Sales', payment = 75},['2'] = { name = 'Business Sales', payment = 100},}}
QBShared.Company['pdm'] = {label = 'pdm',defaultDuty = true,offDutyPay = false,grades = {['0'] = { name = 'Recruit', payment = 50},['1'] = { name = 'Showroom Sales', payment = 75},['2'] = { name = 'Business Sales', payment = 100},['3'] = { name = 'Finance', payment = 125, isowner = true},['4'] = { name = 'Boss', payment = 150, isboss = true, isowner = true},}}
QBShared.Company['luxurymotors'] = {label = 'luxurymotors',defaultDuty = true,offDutyPay = false,grades = {['0'] = { name = 'Recruit', payment = 50},['1'] = { name = 'Showroom Sales', payment = 75},['2'] = { name = 'Business Sales', payment = 100},['3'] = { name = 'Finance', payment = 125, isowner = true},['4'] = { name = 'Boss', payment = 150, isboss = true, isowner = true},}}
QBShared.Company['pdmcar'] = {label = 'pdm',defaultDuty = true,offDutyPay = false,grades = {['4'] = { name = 'Boss', payment = 150, isboss = true, isowner = true},['3'] = { name = 'Finance', payment = 125, isowner = true},['2'] = { name = 'Business Sales', payment = 100},['1'] = { name = 'Showroom Sales', payment = 75},['0'] = { name = 'Recruit', payment = 50},}}