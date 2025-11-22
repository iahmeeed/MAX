-- ماييحتاج تعدل شي هنا  + تسوي عصابه داخل العبه  عن طريق المافيا

QBShared = QBShared or {}
QBShared.Gangs = {
    ['none'] = {
        label = 'No Gang',
        grades = {
            ['0'] = {
                name = 'Unaffiliated'
            },
        },
    },
    ['mafia'] = {
        label = 'Mafia',
        grades = {
            ['0'] = {
                name = 'Recruit'
            },
            ['1'] = {
                name = 'Enforcer'
            },
            ['2'] = {
                name = 'Shot Caller'
            },
            ['3'] = {
                name = 'Boss',
                isboss = true
            },
        },
    },
    ['lastcall'] = {
        label = 'LastCall',
        grades = {
            ['0'] = {
                name = 'Recruit'
            },
        },
    },
}
