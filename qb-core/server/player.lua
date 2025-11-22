QBCore.Players = {}
QBCore.Player = {}

-- On player login get their data or set defaults
-- Don't touch any of this unless you know what you are doing
-- Will cause major issues!

function QBCore.Player.Login(source, citizenid, newData)
    if source and source ~= '' then
        if citizenid then
            local license = QBCore.Functions.GetIdentifier(source, 'license')
            local PlayerData = MySQL.prepare.await('SELECT * FROM players where citizenid = ?', { citizenid })
            if PlayerData and license == PlayerData.license then
                PlayerData.money = json.decode(PlayerData.money)
                PlayerData.job = json.decode(PlayerData.job)
                PlayerData.position = json.decode(PlayerData.position)
                PlayerData.metadata = json.decode(PlayerData.metadata)
                PlayerData.charinfo = json.decode(PlayerData.charinfo)
                PlayerData.company = json.decode(PlayerData.company)
                if PlayerData.gang then
                    PlayerData.gang = json.decode(PlayerData.gang)
                else
                    PlayerData.gang = {}
                end
                QBCore.Player.CheckPlayerData(source, PlayerData)
            else
                -- DropPlayer(source, Lang:t("info.exploit_dropped"))
                TriggerEvent("Rc2-log:server:CreateLog", 'fuckers', 'Fuckers Founded', 'red', GetPlayerName(source) .. ' Has Been Banned For Character Joining Exploit', true)
                QBCore.Functions.Ban(source, Lang:t("info.exploit_dropped"), false)
            end
        else
            QBCore.Player.CheckPlayerData(source, newData)
        end
        return true
    else
        QBCore.ShowError(GetCurrentResourceName(), 'ERROR QBCORE.PLAYER.LOGIN - NO SOURCE GIVEN!')
        return false
    end
end

function QBCore.Player.GetOfflinePlayer(citizenid)
    if citizenid then
        local PlayerData = MySQL.Sync.prepare('SELECT * FROM players where citizenid = ?', {citizenid})
        if PlayerData then
            PlayerData.money = json.decode(PlayerData.money)
            PlayerData.job = json.decode(PlayerData.job)
            PlayerData.position = json.decode(PlayerData.position)
            PlayerData.metadata = json.decode(PlayerData.metadata)
            PlayerData.charinfo = json.decode(PlayerData.charinfo)
            if PlayerData.gang then
                PlayerData.gang = json.decode(PlayerData.gang)
            else
                PlayerData.gang = {}
            end

            return QBCore.Player.CheckPlayerData(nil, PlayerData)
        end
    end
    return nil
end

function QBCore.Player.CheckPlayerData(source, PlayerData)
    PlayerData = PlayerData or {}
    local Offline = true
    if source then
        PlayerData.source = source
        PlayerData.license = PlayerData.license or QBCore.Functions.GetIdentifier(source, 'license')
        if PlayerData.steam then 
            if PlayerData.steam == '1' then 
                PlayerData.steam = QBCore.Functions.GetIdentifier(source, 'steam')
            elseif PlayerData.steam == 'NULL' then 
                PlayerData.steam = QBCore.Functions.GetIdentifier(source, 'steam')
            end
        else
            PlayerData.steam = QBCore.Functions.GetIdentifier(source, 'steam')
        end
        PlayerData.name = GetPlayerName(source)
        Offline = false
    end

    PlayerData.citizenid = PlayerData.citizenid or QBCore.Player.CreateCitizenId()
    PlayerData.cid = PlayerData.cid or 1
    PlayerData.money = PlayerData.money or {}
    PlayerData.optin = PlayerData.optin or true
    for moneytype, startamount in pairs(QBCore.Config.Money.MoneyTypes) do
        PlayerData.money[moneytype] = PlayerData.money[moneytype] or startamount
    end

    -- Charinfo
    PlayerData.charinfo = PlayerData.charinfo or {}
    PlayerData.charinfo.firstname = PlayerData.charinfo.firstname or 'Firstname'
    PlayerData.charinfo.lastname = PlayerData.charinfo.lastname or 'Lastname'
    PlayerData.charinfo.birthdate = PlayerData.charinfo.birthdate or '00-00-0000'
    PlayerData.charinfo.gender = PlayerData.charinfo.gender or 0

    PlayerData.charinfo.backstory = PlayerData.charinfo.backstory or 'placeholder backstory'
    PlayerData.charinfo.nationality = PlayerData.charinfo.nationality or 'USA'
    PlayerData.charinfo.phone = PlayerData.charinfo.phone or QBCore.Functions.CreatePhoneNumber()
    PlayerData.charinfo.account = PlayerData.charinfo.account or QBCore.Functions.CreateAccountNumber()
    -- Metadata
    PlayerData.metadata = PlayerData.metadata or {}
    PlayerData.metadata['hunger'] = PlayerData.metadata['hunger'] or 100
    PlayerData.metadata['thirst'] = PlayerData.metadata['thirst'] or 100
    PlayerData.metadata['stress'] = PlayerData.metadata['stress'] or 0
    PlayerData.metadata['health'] = PlayerData.metadata['health'] or 100
    PlayerData.metadata['isdead'] = PlayerData.metadata['isdead'] or false
    PlayerData.metadata['inapartment'] = PlayerData.metadata['inapartment'] or false
    PlayerData.metadata['inlaststand'] = PlayerData.metadata['inlaststand'] or false
    PlayerData.metadata['armor'] = PlayerData.metadata['armor'] or 0
    PlayerData.metadata['ishandcuffed'] = PlayerData.metadata['ishandcuffed'] or false
    PlayerData.metadata['insurance'] = PlayerData.metadata['insurance'] or 0
    PlayerData.metadata['timerinsurance'] = PlayerData.metadata['timerinsurance'] or ""
    PlayerData.metadata['tracker'] = PlayerData.metadata['tracker'] or false
    PlayerData.metadata['injail'] = PlayerData.metadata['injail'] or 0
    PlayerData.metadata['jailitems'] = PlayerData.metadata['jailitems'] or {}
    PlayerData.metadata['status'] = PlayerData.metadata['status'] or {}
    PlayerData.metadata['phone'] = PlayerData.metadata['phone'] or {}
    PlayerData.metadata['licences'] = PlayerData.metadata['licences'] or {
        ['driver'] = true,
        ['business'] = false,
        ['weapon'] = false,
        ['pilot'] = false,
        ['jaber'] = false
}
    PlayerData.metadata['fitbit'] = PlayerData.metadata['fitbit'] or {}
    PlayerData.metadata['policepoints'] = PlayerData.metadata['policepoints'] or 0
    PlayerData.metadata['ambulancepoints'] = PlayerData.metadata['ambulancepoints'] or 0
    PlayerData.metadata['crimerep'] = PlayerData.metadata['crimerep'] or 0
    PlayerData.metadata['commandbinds'] = PlayerData.metadata['commandbinds'] or {}
    PlayerData.metadata['bloodtype'] = PlayerData.metadata['bloodtype'] or QBCore.Config.Player.Bloodtypes[math.random(1, #QBCore.Config.Player.Bloodtypes)]
    PlayerData.metadata['dealerrep'] = PlayerData.metadata['dealerrep'] or 0
    PlayerData.metadata['craftingrep'] = PlayerData.metadata['craftingrep'] or 0
    PlayerData.metadata['attachmentcraftingrep'] = PlayerData.metadata['attachmentcraftingrep'] or 0
    PlayerData.metadata['currentapartment'] = PlayerData.metadata['currentapartment'] or nil
    PlayerData.metadata['callsign'] = PlayerData.metadata['callsign'] or 'NO TAG'
    PlayerData.metadata['fingerprint'] = PlayerData.metadata['fingerprint'] or QBCore.Player.CreateFingerId()
    PlayerData.metadata['walletid'] = PlayerData.metadata['walletid'] or QBCore.Player.CreateWalletId()
    PlayerData.metadata['walkstyle'] = PlayerData.metadata['walkstyle'] or 'none'
    PlayerData.metadata["policelevel"] = PlayerData.metadata["policelevel"] ~= nil and PlayerData.metadata["policelevel"] or 0
    PlayerData.metadata["ambulancelevel"] = PlayerData.metadata["ambulancelevel"] ~= nil and PlayerData.metadata["ambulancelevel"] or 0
    if PlayerData.metadata['jobrep'] then
        if PlayerData.metadata['jobrep']['garbage'] then 
            PlayerData.metadata['jobrep']['garbage']["payment"] = PlayerData.metadata['jobrep']['garbage']["payment"] or 0
            PlayerData.metadata['jobrep']['garbage']["grade"] = PlayerData.metadata['jobrep']['garbage']["grade"] or 1
            PlayerData.metadata['jobrep']['garbage']["progress"] = PlayerData.metadata['jobrep']['garbage']["progress"] or 1
            PlayerData.metadata['jobrep']['garbage']["goods"] = PlayerData.metadata['jobrep']['garbage']["goods"] or 0
        else
            PlayerData.metadata['jobrep']['garbage'] = {
                ["payment"] = 0,
                ["grade"] = 1,
                ["progress"] = 1,
                ["goods"] = 0,
            }
        end
        if PlayerData.metadata['jobrep']['tow'] then 
            PlayerData.metadata['jobrep']['tow']["payment"] = PlayerData.metadata['jobrep']['tow']["payment"] or 0
            PlayerData.metadata['jobrep']['tow']["grade"] = PlayerData.metadata['jobrep']['tow']["grade"] or 1
            PlayerData.metadata['jobrep']['tow']["progress"] = PlayerData.metadata['jobrep']['tow']["progress"] or 1
            PlayerData.metadata['jobrep']['tow']["goods"] = PlayerData.metadata['jobrep']['tow']["goods"] or 0
        else
            PlayerData.metadata['jobrep']['tow'] = {
                ["payment"] = 0,
                ["grade"] = 1,
                ["progress"] = 1,
                ["goods"] = 0,
            }
        end
        if PlayerData.metadata['jobrep']['taxi'] then 
            PlayerData.metadata['jobrep']['taxi']["payment"] = PlayerData.metadata['jobrep']['taxi']["payment"] or 0
            PlayerData.metadata['jobrep']['taxi']["grade"] = PlayerData.metadata['jobrep']['taxi']["grade"] or 1
            PlayerData.metadata['jobrep']['taxi']["progress"] = PlayerData.metadata['jobrep']['taxi']["progress"] or 1
            PlayerData.metadata['jobrep']['taxi']["goods"] = PlayerData.metadata['jobrep']['taxi']["goods"] or 0
        else
            PlayerData.metadata['jobrep']['taxi'] = {
                ["payment"] = 0,
                ["grade"] = 1,
                ["progress"] = 1,
                ["goods"] = 0,
            }
        end
	else
		PlayerData.metadata['jobrep'] = {
            ['garbage'] = {
                ["payment"] = 0,
                ["grade"] = 1,
                ["progress"] = 1,
                ["goods"] = 0,
            },
			['tow'] = {
                ["payment"] = 0,
                ["grade"] = 1,
                ["progress"] = 1,
                ["goods"] = 0,
            },
			['trucker'] = {
                ["payment"] = 0,
                ["grade"] = 1,
                ["progress"] = 1,
                ["goods"] = 0,
            },
			['taxi'] = {
                ["payment"] = 0,
                ["grade"] = 1,
                ["progress"] = 1,
                ["goods"] = 0,
            },
		}
	end

    if PlayerData.metadata['cops'] then
        PlayerData.metadata['cops']['dispatch'] = PlayerData.metadata['cops']['dispatch'] or false
        PlayerData.metadata['cops']['iswing'] = PlayerData.metadata['cops']['iswing'] or false
        PlayerData.metadata['cops']['ismotor'] = PlayerData.metadata['cops']['ismotor'] or false
        PlayerData.metadata['cops']['dutyhours'] = PlayerData.metadata['cops']['dutyhours'] or 0
        PlayerData.metadata['cops']['dispatchpoints'] = PlayerData.metadata['cops']['dispatchpoints'] or 0
        PlayerData.metadata['cops']['points'] = PlayerData.metadata['cops']['points'] or 0
    else
        PlayerData.metadata['cops'] = {
            ["dispatch"] = false,
            ["iswing"] = false,
            ["ismotor"] = false,
            ["dutyhours"] = 0,
            ["dispatchpoints"] = 0,
            ["points"] = 0,
        }
    end
    
    if PlayerData.metadata['ems'] then
        PlayerData.metadata['ems']['dispatch'] = PlayerData.metadata['ems']['dispatch'] or false
        PlayerData.metadata['ems']['iswing'] = PlayerData.metadata['ems']['iswing'] or false
        PlayerData.metadata['ems']['dutyhours'] = PlayerData.metadata['ems']['dutyhours'] or 0
        PlayerData.metadata['ems']['dispatchpoints'] = PlayerData.metadata['ems']['dispatchpoints'] or 0
    else
        PlayerData.metadata['ems'] = {
            ["dispatch"] = false,
            ["iswing"] = false,
            ["dutyhours"] = 0,
            ["dispatchpoints"] = 0,
        }
    end

    if PlayerData.metadata.crypto then 
        PlayerData.metadata.crypto.shung = PlayerData.metadata.crypto.shung or 0
        PlayerData.metadata.crypto.gne = PlayerData.metadata.crypto.gne or 0
        PlayerData.metadata.crypto.xcoin = PlayerData.metadata.crypto.xcoin or 0
        PlayerData.metadata.crypto.lme = PlayerData.metadata.crypto.lme or 0
    else
        PlayerData.metadata.crypto = {
            shung = 0,
            gne = 0,
            xcoin = 0,
            lme = 0,
        }
    end

    if PlayerData.metadata.paycheck then 
        PlayerData.metadata.paycheck.amount = PlayerData.metadata.paycheck.amount or 0
        PlayerData.metadata.paycheck.ispaymentday = PlayerData.metadata.paycheck.ispaymentday or false
        PlayerData.metadata.paycheck.ispaid = PlayerData.metadata.paycheck.ispaid or false
    else
        PlayerData.metadata.paycheck = {
            amount = 0,
            ispaymentday = false,
            ispaid = false,
        }
    end

    if PlayerData.metadata.criminalrecord then 
        PlayerData.metadata.criminalrecord.hasRecord = PlayerData.metadata.criminalrecord.hasRecord or false
        PlayerData.metadata.criminalrecord.date = PlayerData.metadata.criminalrecord.date or nil
    else
        PlayerData.metadata.criminalrecord = {
            hasRecord = false,
            date = nil,
        }
    end

    if PlayerData.metadata.dailyluck then 
        PlayerData.metadata.dailyluck.luck = PlayerData.metadata.dailyluck.luck or 0
    else
        PlayerData.metadata.dailyluck = {
            luck = 0,
        }
    end

    if PlayerData.metadata['recycle'] then
        PlayerData.metadata['recycle']["amount"] = PlayerData.metadata['recycle']["amount"] or 0
        PlayerData.metadata['recycle']["grade"] = PlayerData.metadata['recycle']["grade"] or 1
        PlayerData.metadata['recycle']["progress"] = PlayerData.metadata['recycle']["progress"] or 1
    else
        PlayerData.metadata['recycle'] = {
            ["amount"] = 0,
            ["grade"] = 1,
            ["progress"] = 1,
        }
    end

    if PlayerData.metadata['weapons'] then
        PlayerData.metadata['weapons']["iscrafting"] = PlayerData.metadata['weapons']["iscrafting"] or false
        PlayerData.metadata['weapons']["isammo"] = PlayerData.metadata['weapons']["isammo"] or false
        PlayerData.metadata['weapons']["ammoamount"] = PlayerData.metadata['weapons']["ammoamount"] or 0
        PlayerData.metadata['weapons']["ammotype"] = PlayerData.metadata['weapons']["ammotype"] or 'none'
        PlayerData.metadata['weapons']["weapon"] = PlayerData.metadata['weapons']["weapon"] or 'none'
        PlayerData.metadata['weapons']["time"] = PlayerData.metadata['weapons']["time"] or 0
        PlayerData.metadata['weapons']["xp"] = PlayerData.metadata['weapons']["xp"] or 0
    else
        PlayerData.metadata['weapons'] = {
            ["iscrafting"] = false,
            ["isammo"] = false,
            ["ammoamount"] = 0,
            ["ammotype"] = 'none',
            ["weapon"] = 'none',
            ["time"] = 0,
            ["xp"] = 0,
        }
    end

    if PlayerData.metadata['blueprint'] then
        PlayerData.metadata['blueprint']["pistol_ammo"] = PlayerData.metadata['blueprint']["pistol_ammo"] or false
        PlayerData.metadata['blueprint']["weapon_snspistol"] = PlayerData.metadata['blueprint']["weapon_snspistol"] or false
        PlayerData.metadata['blueprint']["weapon_snspistol_mk2"] = PlayerData.metadata['blueprint']["weapon_snspistol_mk2"] or false
        PlayerData.metadata['blueprint']["weapon_pistol"] = PlayerData.metadata['blueprint']["weapon_pistol"] or false
        PlayerData.metadata['blueprint']["weapon_pistol_mk2"] = PlayerData.metadata['blueprint']["weapon_pistol_mk2"] or false
        PlayerData.metadata['blueprint']["weapon_pistol50"] = PlayerData.metadata['blueprint']["weapon_pistol50"] or false
        PlayerData.metadata['blueprint']["weapon_heavypistol"] = PlayerData.metadata['blueprint']["weapon_heavypistol"] or false
        PlayerData.metadata['blueprint']["weapon_vintagepistol"] = PlayerData.metadata['blueprint']["weapon_vintagepistol"] or false
    else
        PlayerData.metadata['blueprint'] = {
            ["pistol_ammo"] = false,
            ["weapon_snspistol"] = false,
            ["weapon_snspistol_mk2"] = false,
            ["weapon_pistol"] = false,
            ["weapon_pistol_mk2"] = false,
            ["weapon_pistol50"] = false,
            ["weapon_heavypistol"] = false,
            ["weapon_vintagepistol"] = false,
        }
    end

    if PlayerData.metadata['crafting'] then
        if PlayerData.metadata['crafting']['weapons'] then 
            PlayerData.metadata['crafting']['weapons']["level"] = PlayerData.metadata['crafting']['weapons']["level"] or 1
        else
            PlayerData.metadata['crafting']['weapons'] = {
                ["level"] = 1,
            }
        end
	else
		PlayerData.metadata['crafting'] = {
            ['weapons'] = {
                ["level"] = 1,
            },
        }
	end

    if PlayerData.metadata['scrapdata'] then
        PlayerData.metadata['scrapdata']["amount"] = PlayerData.metadata['scrapdata']["amount"] or 0
        PlayerData.metadata['scrapdata']["item"] = PlayerData.metadata['scrapdata']["item"] or 'none'
        PlayerData.metadata['scrapdata']["time"] = PlayerData.metadata['scrapdata']["time"] or 0
    else
        PlayerData.metadata['scrapdata'] = {
            ["amount"] = 0,
            ["item"] = 'none',
            ["time"] = 0,
        }
    end

    if PlayerData.metadata['moneyboost'] then
        PlayerData.metadata['moneyboost']["amount"] = PlayerData.metadata['moneyboost']["amount"] or 0
        PlayerData.metadata['moneyboost']["stresshold"] = PlayerData.metadata['moneyboost']["stresshold"] or false
    else
        PlayerData.metadata['moneyboost'] = {
            ["amount"] = 0,
            ["stresshold"] = false,
        }
    end

    if PlayerData.metadata['tracker'] then
        PlayerData.metadata['tracker']["istracked"] = PlayerData.metadata['tracker']["istracked"] or false
    else
        PlayerData.metadata['tracker'] = {
            ["istracked"] = false,
        }
    end

    if PlayerData.metadata['licences'] then
        PlayerData.metadata['licences']["driver"] = PlayerData.metadata['licences']["driver"] or true
        PlayerData.metadata['licences']["business"] = PlayerData.metadata['licences']["business"] or false
        PlayerData.metadata['licences']["weapon"] = PlayerData.metadata['licences']["weapon"] or false
    else
        PlayerData.metadata['licences'] = {
            ['driver'] = true,
            ['business'] = false,
            ['weapon'] = false
        }
    end

    if PlayerData.metadata['fishing'] then
        PlayerData.metadata['fishing']["grade"] = PlayerData.metadata['fishing']["grade"] or 1
        PlayerData.metadata['fishing']["progress"] = PlayerData.metadata['fishing']["progress"] or 1
    else
        PlayerData.metadata['fishing'] = {
            ["grade"] = 1,
            ["progress"] = 1,
        }
    end

    PlayerData.metadata['carboostclass'] = PlayerData.metadata['carboostclass'] or 'D'
    PlayerData.metadata['carboostrep'] = PlayerData.metadata['carboostrep'] or 0

    if PlayerData.metadata['laptop'] then 
        PlayerData.metadata['laptop']['background'] = PlayerData.metadata['laptop']['background'] or 'default'
        PlayerData.metadata['laptop']['darkfont'] = PlayerData.metadata['laptop']['darkfont'] or false
    else
        PlayerData.metadata['laptop'] = {
            ["background"] = 'default',
            ["darkfont"] = false,
        }
    end

    if PlayerData.metadata['melting'] then 
        if PlayerData.metadata['melting']['gold'] then 
            PlayerData.metadata['melting']['gold']['amount'] = PlayerData.metadata['melting']['gold']['amount'] or 0
            PlayerData.metadata['melting']['gold']['ismelting'] = PlayerData.metadata['melting']['gold']['ismelting'] or false
        else
            PlayerData.metadata['melting']['gold'] = {
                amount = 0,
                ismelting = false
            }
        end
    else
        PlayerData.metadata['melting'] = {
            ["gold"] = {
                amount = 0,
                ismelting = false
            },
        }
    end

    if PlayerData.metadata['policefines'] then 
        PlayerData.metadata['policefines']['amount'] = PlayerData.metadata['policefines']['amount'] or 0
    else
        PlayerData.metadata['policefines'] = {
            ["amount"] = 0,
        }
    end

    if PlayerData.metadata['crime'] then
        if PlayerData.metadata['crime']['lester'] then 
            PlayerData.metadata['crime']['lester']["moneystorm"] = PlayerData.metadata['crime']['lester']["moneystorm"] or {}
            PlayerData.metadata['crime']['lester']["moneystorm"]["progress"] = PlayerData.metadata['crime']['lester']["moneystorm"]["progress"] or 1
            PlayerData.metadata['crime']['lester']["moneystorm"]["grade"] = PlayerData.metadata['crime']['lester']["moneystorm"]["grade"] or 1
        else
            PlayerData.metadata['crime']['lester'] = {
                ["moneystorm"] = {
                    ["progress"] = 1,
                    ["grade"] = 1,
                },
            }
        end
        if PlayerData.metadata['crime']['storerobbery'] then 
            PlayerData.metadata['crime']['storerobbery']["grade"] = PlayerData.metadata['crime']['storerobbery']["grade"] or 1
            PlayerData.metadata['crime']['storerobbery']["progress"] = PlayerData.metadata['crime']['storerobbery']["progress"] or 1
            PlayerData.metadata['crime']['storerobbery']["hackskill"] = PlayerData.metadata['crime']['storerobbery']["hackskill"] or 1
        else
            PlayerData.metadata['crime']['storerobbery'] = {
                ["grade"] = 1,
                ["progress"] = 1,
                ["hackskill"] = 1,
            }
        end
        
        if PlayerData.metadata['crime']['smallmoneywash'] then 
            PlayerData.metadata['crime']['smallmoneywash']["grade"] = PlayerData.metadata['crime']['smallmoneywash']["grade"] or 1
            PlayerData.metadata['crime']['smallmoneywash']["amount"] = PlayerData.metadata['crime']['smallmoneywash']["amount"] or 0
            PlayerData.metadata['crime']['smallmoneywash']["progress"] = PlayerData.metadata['crime']['smallmoneywash']["progress"] or 0
            PlayerData.metadata['crime']['smallmoneywash']["time"] = PlayerData.metadata['crime']['smallmoneywash']["time"] or 0
            PlayerData.metadata['crime']['smallmoneywash']["iswashing"] = PlayerData.metadata['crime']['smallmoneywash']["iswashing"] or false
        else
            PlayerData.metadata['crime']['smallmoneywash'] = {
                ["grade"] = 1,
                ["amount"] = 1,
                ["progress"] = 1,
                ["time"] = 0,
                ["iswashing"] = false,
            }
        end
	else
		PlayerData.metadata['crime'] = {
            ['lester'] = {
                ["moneystorm"] = {
                    ["progress"] = 1,
                    ["grade"] = 1,
                },
            },
            ['storerobbery'] = {
                ["grade"] = 1,
                ["progress"] = 1,
                ["hackskill"] = 1,
            },
            ['smallmoneywash'] = {
                ["grade"] = 1,
                ["amount"] = 0,
                ["time"] = 0,
                ["progress"] = 0,
                ["iswashing"] = false,
            },
        }
	end

    PlayerData.metadata['inside'] = PlayerData.metadata['inside'] or {
        house = nil,
        apartment = {
            apartmentType = nil,
            apartmentId = nil,
        }
    }
    PlayerData.metadata['phonedata'] = PlayerData.metadata['phonedata'] or {
        SerialNumber = QBCore.Player.CreateSerialNumber(),
        InstalledApps = {},
    }

    PlayerData.metadata['timeplayedh'] = PlayerData.metadata['timeplayedh'] or 0
    PlayerData.metadata['timeplayedm'] = PlayerData.metadata['timeplayedm'] or 0
    PlayerData.metadata['callbalance'] = PlayerData.metadata['callbalance'] or 0

    PlayerData.metadata['services'] = PlayerData.metadata['services'] or false


    -- Job
    if PlayerData.job and PlayerData.job.name and not QBCore.Shared.Jobs[PlayerData.job.name] then PlayerData.job = nil end
    PlayerData.job = PlayerData.job or {}
    PlayerData.job.name = PlayerData.job.name or 'unemployed'
    PlayerData.job.label = PlayerData.job.label or 'Civilian'
    PlayerData.job.payment = PlayerData.job.payment or 10
    PlayerData.job.type = PlayerData.job.type or 'none'
    if QBCore.Shared.ForceJobDefaultDutyAtLogin or PlayerData.job.onduty == nil then
        PlayerData.job.onduty = QBCore.Shared.Jobs[PlayerData.job.name].defaultDuty
    end
    PlayerData.job.isboss = PlayerData.job.isboss or false
    PlayerData.job.grade = PlayerData.job.grade or {}
    PlayerData.job.grade.name = PlayerData.job.grade.name or 'Freelancer'
    PlayerData.job.grade.level = PlayerData.job.grade.level or 0
    PlayerData.job.dutys = PlayerData.job.dutys or {
        Break = false,
        Busy = false,
        Dispatch = false,
    }
    -- company
    if PlayerData.company and PlayerData.company.name and not QBCore.Shared.Company[PlayerData.company.name] then PlayerData.company = nil end
    PlayerData.company = PlayerData.company or {}
    print("Type of playerData:", type(playerData))
    PlayerData.company.name = PlayerData.company.name or 'none'
    PlayerData.company.label = PlayerData.company.label or 'none'
    PlayerData.company.payment = PlayerData.company.payment or 10
    if QBCore.Shared.ForceCompanyDefaultDutyAtLogin or PlayerData.company.onduty == nil then
        PlayerData.company.onduty = QBCore.Shared.Company[PlayerData.company.name].defaultDuty
    end
    PlayerData.company.isboss = PlayerData.company.isboss or false
    PlayerData.company.isowner = PlayerData.company.isowner or false
    PlayerData.company.grade = PlayerData.company.grade or {}
    PlayerData.company.grade.name = PlayerData.company.grade.name or 'worker'
    PlayerData.company.grade.level = PlayerData.company.grade.level or 0
    -- Gang
    if PlayerData.gang and PlayerData.gang.name and not QBCore.Shared.Gangs[PlayerData.gang.name] then PlayerData.gang = nil end
    PlayerData.gang = PlayerData.gang or {}
    PlayerData.gang.name = PlayerData.gang.name or 'none'
    PlayerData.gang.label = PlayerData.gang.label or 'No Gang Affiliaton'
    PlayerData.gang.isboss = PlayerData.gang.isboss or false
    PlayerData.gang.grade = PlayerData.gang.grade or {}
    PlayerData.gang.grade.name = PlayerData.gang.grade.name or 'none'
    PlayerData.gang.grade.level = PlayerData.gang.grade.level or 0
    PlayerData.gang.spray = PlayerData.gang.spray or {}
    PlayerData.gang.spray.spraycount = PlayerData.gang.spray.spraycount or 0
    PlayerData.gang.spray.xp = PlayerData.gang.spray.xp or 0
    PlayerData.gang.spray.sprayremovecount = PlayerData.gang.spray.sprayremovecount or 0
    -- Other
    PlayerData.position = PlayerData.position or QBConfig.DefaultSpawn
    PlayerData.items = GetResourceState('qb-inventory') ~= 'missing' and exports['qb-inventory']:LoadInventory(PlayerData.source, PlayerData.citizenid) or {}
    return QBCore.Player.CreatePlayer(PlayerData, Offline)
end

-- On player logout

function QBCore.Player.Logout(source)
    TriggerClientEvent('QBCore:Client:OnPlayerUnload', source)
    TriggerEvent('QBCore:Server:OnPlayerUnload', source)
    TriggerClientEvent('QBCore:Player:UpdatePlayerData', source)
    Wait(200)
    QBCore.Players[source] = nil
end

-- Create a new character
-- Don't touch any of this unless you know what you are doing
-- Will cause major issues!

function QBCore.Player.CreatePlayer(PlayerData, Offline)
    local self = {}
    self.Functions = {}
    self.PlayerData = PlayerData
    self.Offline = Offline

    function self.Functions.UpdatePlayerData()
        if self.Offline then return end -- Unsupported for Offline Players
        TriggerEvent('QBCore:Player:SetPlayerData', self.PlayerData)
        TriggerClientEvent('QBCore:Player:SetPlayerData', self.PlayerData.source, self.PlayerData)
    end

    function self.Functions.SetJob(job, grade)
        job = job:lower()
        grade = tostring(grade) or '0'
        if not QBCore.Shared.Jobs[job] then return false end
        self.PlayerData.job.name = job
        self.PlayerData.job.label = QBCore.Shared.Jobs[job].label
        self.PlayerData.job.onduty = QBCore.Shared.Jobs[job].defaultDuty
        self.PlayerData.job.type = QBCore.Shared.Jobs[job].type or 'none'
        if QBCore.Shared.Jobs[job].grades[grade] then
            local jobgrade = QBCore.Shared.Jobs[job].grades[grade]
            self.PlayerData.job.grade = {}
            self.PlayerData.job.grade.name = jobgrade.name
            self.PlayerData.job.grade.level = tonumber(grade)
            self.PlayerData.job.payment = jobgrade.payment or 30
            self.PlayerData.job.isboss = jobgrade.isboss or false
        else
            self.PlayerData.job.grade = {}
            self.PlayerData.job.grade.name = 'No Grades'
            self.PlayerData.job.grade.level = 0
            self.PlayerData.job.payment = 30
            self.PlayerData.job.isboss = false
        end

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            TriggerEvent('QBCore:Server:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
            TriggerClientEvent('QBCore:Client:OnJobUpdate', self.PlayerData.source, self.PlayerData.job)
        end

        return true
    end

    function self.Functions.SetCompany(company, grade)
        local company = company:lower()
        local grade = tostring(grade) or '1'

        if QBCore.Shared.Company[company] then
            self.PlayerData.company.name = company
            self.PlayerData.company.label = QBCore.Shared.Company[company].label
            self.PlayerData.company.onduty = QBCore.Shared.Company[company].defaultDuty

            if QBCore.Shared.Company[company].grades[grade] then
                local companygrade = QBCore.Shared.Company[company].grades[grade]
                self.PlayerData.company.grade = {}
                self.PlayerData.company.grade.name = companygrade.name
                self.PlayerData.company.grade.level = tonumber(grade)
                self.PlayerData.company.payment = companygrade.payment or 10
                self.PlayerData.company.isboss = companygrade.isboss or false
                self.PlayerData.company.isowner = companygrade.isowner or false
            else
                self.PlayerData.company.grade = {}
                self.PlayerData.company.grade.name = 'No Grades'
                self.PlayerData.company.grade.level = 1
                self.PlayerData.company.payment = 10
                self.PlayerData.company.isboss = false
                self.PlayerData.company.isowner = false
            end

            if not self.Offline then
                self.Functions.UpdatePlayerData()
                TriggerEvent('QBCore:Server:OnCompanyUpdate', self.PlayerData.source, self.PlayerData.company)
                TriggerClientEvent('QBCore:Client:OnCompanyUpdate', self.PlayerData.source, self.PlayerData.company)
            end
            return true
        end

        return false
    end

    function self.Functions.SetGang(gang, grade, gangs)
        gang = gang:lower()
        grade = tostring(grade) or '0'

        if gangs then
            QBCore.Shared.Gangs = gangs
        end
        
        if not QBCore.Shared.Gangs[gang] then return false end
        self.PlayerData.gang.name = gang
        self.PlayerData.gang.label = QBCore.Shared.Gangs[gang].label
        if QBCore.Shared.Gangs[gang].grades[grade] then
            local ganggrade = QBCore.Shared.Gangs[gang].grades[grade]
            self.PlayerData.gang.grade = {}
            self.PlayerData.gang.grade.name = ganggrade.name
            self.PlayerData.gang.grade.level = tonumber(grade)
            self.PlayerData.gang.isboss = ganggrade.isboss or false
        else
            self.PlayerData.gang.grade = {}
            self.PlayerData.gang.grade.name = 'No Grades'
            self.PlayerData.gang.grade.level = 0
            self.PlayerData.gang.isboss = false
        end

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            TriggerEvent('QBCore:Server:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
            TriggerClientEvent('QBCore:Client:OnGangUpdate', self.PlayerData.source, self.PlayerData.gang)
        end

        return true
    end

    self.Functions.PayCheck = function(amount, ispaymentday, ispaid)
        if amount then 
            self.PlayerData.metadata['paycheck'] = {
                ["amount"] = tonumber(amount),
                ["ispaymentday"] = ispaymentday,
                ["ispaid"] = ispaid
            }
        else
            self.PlayerData.metadata['paycheck'] = {
                ["amount"] = self.PlayerData.metadata['paycheck']["amount"],
                ["ispaymentday"] = ispaymentday,
                ["ispaid"] = ispaid
            }
        end
        self.Functions.UpdatePlayerData()
    end

    self.Functions.SetJobsMeta = function(job, meta, val)
        if not job then return end
        if not meta then return end
        if not val then return end
        local meta = meta:lower()
        local job = job:lower()
        if val ~= nil then
            self.PlayerData.metadata['jobrep'][job] = val
            self.Functions.UpdatePlayerData()
        end
    end

    self.Functions.SetCrime = function(crime, val)
        local crime = crime:lower()
        if val ~= nil then
            self.PlayerData.metadata['crime'][crime] = val
            self.Functions.UpdatePlayerData()
        end
    end


    self.Functions.SetPlayTime = function(valh, valm)
        if valh ~= nil and valm ~= nil then
            self.PlayerData.metadata['timeplayedh'] = valh
            self.PlayerData.metadata['timeplayedm'] = valm
            self.Functions.UpdatePlayerData()
        end
    end

    self.Functions.SetCopsPoints = function(info, val)
        local info = info:lower()
        if val ~= nil then
            self.PlayerData.metadata['cops'][info] = val
            self.Functions.UpdatePlayerData()
        end
    end

    self.Functions.SetEmsPoints = function(info, val)
        local info = info:lower()
        if val ~= nil then
            self.PlayerData.metadata['ems'][info] = val
            self.Functions.UpdatePlayerData()
        end
    end

    self.Functions.SetCopsData = function(info)
        if info ~= nil then
            self.PlayerData.metadata['cops'] = info
            self.Functions.UpdatePlayerData()
        end
    end

    self.Functions.SetEmsData = function(info)
        if info ~= nil then
            self.PlayerData.metadata['ems'] = info
            self.Functions.UpdatePlayerData()
        end
    end

    self.Functions.SetPlayTime = function(valh, valm)
        if valh ~= nil and valm ~= nil then
            self.PlayerData.metadata['timeplayedh'] = valh
            self.PlayerData.metadata['timeplayedm'] = valm
            self.Functions.UpdatePlayerData()
        end
    end

    self.Functions.SetSmallWash = function(val)
        if val ~= nil then
            self.PlayerData.metadata['crime']["smallmoneywash"] = val
            self.Functions.UpdatePlayerData()
        end
    end

    function self.Functions.UpdatePhoneNumber(Number)
        if not Number then return false end
        self.PlayerData.charinfo.phone = Number
        self.Functions.UpdatePlayerData()
        return true
    end

    function self.Functions.SetJobDuty(onDuty)
        self.PlayerData.job.onduty = not not onDuty -- Make sure the value is a boolean if nil is sent
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.SetCompanyDuty(onDuty)
        self.PlayerData.company.onduty = onDuty
        self.Functions.UpdatePlayerData()
    end

    self.Functions.SetMoneyBoost = function(val)
        if val ~= nil then
            self.PlayerData.metadata['moneyboost'] = val
            self.Functions.UpdatePlayerData()
        end
    end

    function self.Functions.SetPlayerData(key, val)
        if not key or type(key) ~= 'string' then return end
        self.PlayerData[key] = val
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.SetMetaData(meta, val)
        if not meta or type(meta) ~= 'string' then return end
        if meta == 'hunger' or meta == 'thirst' then
            val = val > 100 and 100 or val
        end
        self.PlayerData.metadata[meta] = val
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.GetMetaData(meta)
        if not meta or type(meta) ~= 'string' then return end
        return self.PlayerData.metadata[meta]
    end

    function self.Functions.AddJobReputation(amount)
        if not amount then return end
        amount = tonumber(amount)
        self.PlayerData.metadata['jobrep'][self.PlayerData.job.name] = self.PlayerData.metadata['jobrep'][self.PlayerData.job.name] + amount
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.AddMoney(moneytype, amount, reason)
        local scriptname = GetInvokingResource()
        if not QBCore.QBResources[scriptname] then 
            TriggerEvent('Rc2-log:server:CreateLog', 'fuckers', 'New Fucker', 'red', GetPlayerName(self.PlayerData.source) .. ' Have Been Mraked As Cheater [ Spawn Money ] | [ '..scriptname..' ]', true)
            print('[ '..self.PlayerData.source..' ] is money cheater [ '..scriptname..' ]')
            DropPlayer(self.PlayerData.source, 'Hello noob')
            return
        end
        reason = reason or 'unknown'
        if reason == 'unknown' then 
            print(''..scriptname..' Has no reason')
        end
        moneytype = moneytype:lower()
        amount = tonumber(amount)
        if amount < 0 then return end
        if not self.PlayerData.money[moneytype] then return false end
        self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] + amount

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            if reason == 'unknown' then 
                if amount > 100000 then
                    TriggerEvent("Rc2-log:server:CreateLog", 
                        "alotofmoney",
                        "Money Added",
                        "orange",
                        '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason,
                        true
                    ) 
                else
                    TriggerEvent("Rc2-log:server:CreateLog", 
                        "playeraddmoney",
                        "Money Added",
                        "orange",
                        '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason,
                        false
                    ) 
                end
            else
                if amount > 100000 then
                    TriggerEvent("Rc2-log:server:CreateLog", 
                        "alotofmoney",
                        "Money Added",
                        "green",
                        '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason,
                        true
                    ) 
                else
                    TriggerEvent("Rc2-log:server:CreateLog", 
                        "playeraddmoney",
                        "Money Added",
                        "green",
                        '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason,
                        false
                    ) 
                end
            end
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, false, reason)
            TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount, "add", reason)
            TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount, "add", reason)
        end
        return true
    end

    function self.Functions.RemoveMoney(moneytype, amount, reason)
        reason = reason or 'unknown'
        moneytype = moneytype:lower()
        amount = tonumber(amount)
        if amount < 0 then return end
        if not self.PlayerData.money[moneytype] then return false end
        for _, mtype in pairs(QBCore.Config.Money.DontAllowMinus) do
            if mtype == moneytype then
                if (self.PlayerData.money[moneytype] - amount) < 0 then
                    return false
                end
            end
        end
        self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            if reason == 'unknown' then 
                if amount > 100000 then
                    TriggerEvent("Rc2-log:server:CreateLog", 
                        "alotofmoney",
                        "Money Removed",
                        "orange",
                        '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason,
                        true
                    ) 
                else
                    TriggerEvent("Rc2-log:server:CreateLog", 
                        "playerremovemoney",
                        "Money Removed",
                        "orange",
                        '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason,
                        false
                    ) 
                end
            else
                if amount > 100000 then
                    TriggerEvent("Rc2-log:server:CreateLog", 
                        "alotofmoney",
                        "Money Removed",
                        "red",
                        '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason,
                        true
                    ) 
                else
                    TriggerEvent("Rc2-log:server:CreateLog", 
                        "playerremovemoney",
                        "Money Removed",
                        "red",
                        '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason,
                        false
                    ) 
                end
            end
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, true, reason)
            if moneytype == 'bank' then
                TriggerClientEvent('Rc2-phone:client:RemoveBankMoney', self.PlayerData.source, amount)
            end
            TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount, "remove", reason)
            TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount, "remove", reason)
        end

        return true
    end

    function self.Functions.SetMoney(moneytype, amount, reason)
        reason = reason or 'unknown'
        moneytype = moneytype:lower()
        amount = tonumber(amount)
        if amount < 0 then return false end
        if not self.PlayerData.money[moneytype] then return false end
        local difference = amount - self.PlayerData.money[moneytype]
        self.PlayerData.money[moneytype] = amount

        if not self.Offline then
            self.Functions.UpdatePlayerData()
            TriggerEvent("Rc2-log:server:CreateLog", 'playermoney', 'SetMoney', 'green', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') set, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype] .. ' reason: ' .. reason)
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, math.abs(difference), difference < 0, reason)
            TriggerClientEvent('QBCore:Client:OnMoneyChange', self.PlayerData.source, moneytype, amount, "set", reason)
            TriggerEvent('QBCore:Server:OnMoneyChange', self.PlayerData.source, moneytype, amount, "set", reason)
        end

        return true
    end

    function self.Functions.GetMoney(moneytype)
        if not moneytype then return false end
        moneytype = moneytype:lower()
        return self.PlayerData.money[moneytype]
    end

    function self.Functions.SetCreditCard(cardNumber)
        self.PlayerData.charinfo.card = cardNumber
        self.Functions.UpdatePlayerData()
    end

    function self.Functions.GetCardSlot(cardNumber, cardType)
        local item = tostring(cardType):lower()
        local slots = exports['qb-inventory']:GetSlotsByItem(self.PlayerData.items, item)
        for _, slot in pairs(slots) do
            if slot then
                if self.PlayerData.items[slot].info.cardNumber == cardNumber then
                    return slot
                end
            end
        end
        return nil
    end

    function self.Functions.Save()
        if self.Offline then
            QBCore.Player.SaveOffline(self.PlayerData)
        else
            QBCore.Player.Save(self.PlayerData.source)
        end
    end

    function self.Functions.Logout()
        if self.Offline then return end -- Unsupported for Offline Players
        QBCore.Player.Logout(self.PlayerData.source)
    end

    function self.Functions.AddMethod(methodName, handler)
        self.Functions[methodName] = handler
    end

    function self.Functions.AddField(fieldName, data)
        self[fieldName] = data
    end

    if self.Offline then
        return self
    else
        QBCore.Players[self.PlayerData.source] = self
        QBCore.Player.Save(self.PlayerData.source)

        -- At this point we are safe to emit new instance to third party resource for load handling
        TriggerEvent('QBCore:Server:PlayerLoaded', self)
        self.Functions.UpdatePlayerData()
    end
end

function QBCore.Functions.AddPlayerMethod(ids, methodName, handler)
    local idType = type(ids)
    if idType == "number" then
        if ids == -1 then
            for _, v in pairs(QBCore.Players) do
                v.Functions.AddMethod(methodName, handler)
            end
        else
            if not QBCore.Players[ids] then return end

            QBCore.Players[ids].Functions.AddMethod(methodName, handler)
        end
    elseif idType == "table" and table.type(ids) == "array" then
        for i = 1, #ids do
            QBCore.Functions.AddPlayerMethod(ids[i], methodName, handler)
        end
    end
end

function QBCore.Functions.AddPlayerField(ids, fieldName, data)
    local idType = type(ids)
    if idType == "number" then
        if ids == -1 then
            for _, v in pairs(QBCore.Players) do
                v.Functions.AddField(fieldName, data)
            end
        else
            if not QBCore.Players[ids] then return end

            QBCore.Players[ids].Functions.AddField(fieldName, data)
        end
    elseif idType == "table" and table.type(ids) == "array" then
        for i = 1, #ids do
            QBCore.Functions.AddPlayerField(ids[i], fieldName, data)
        end
    end
end


-- Save player info to database (make sure citizenid is the primary key in your database)

function QBCore.Player.Save(source)
    local ped = GetPlayerPed(source)
    local pcoords = GetEntityCoords(ped)
    local playercoords = {
        x = pcoords.x,
        y = pcoords.y,
        z = pcoords.z,
        h = GetEntityHeading(ped),
    }
    local PlayerData = QBCore.Players[source].PlayerData
    if PlayerData then
        MySQL.insert('INSERT INTO players (citizenid, cid, license, steam, name, money, charinfo, job, gang, position, metadata, company) VALUES (:citizenid, :cid, :license, :steam, :name, :money, :charinfo, :job, :gang, :position, :metadata, :company) ON DUPLICATE KEY UPDATE cid = :cid, steam = :steam, name = :name, money = :money, charinfo = :charinfo, job = :job, gang = :gang, position = :position, metadata = :metadata, company = :company', {
            citizenid = PlayerData.citizenid,
            cid = tonumber(PlayerData.cid),
            license = PlayerData.license,
           -- steam = PlayerData.steam,
            name = PlayerData.name,
            money = json.encode(PlayerData.money),
            charinfo = json.encode(PlayerData.charinfo),
            job = json.encode(PlayerData.job),
            gang = json.encode(PlayerData.gang),
            position = json.encode(playercoords),
            metadata = json.encode(PlayerData.metadata),
            company = json.encode(PlayerData.company),
        })
        if GetResourceState('qb-inventory') ~= 'missing' then exports['qb-inventory']:SaveInventory(source) end
        local savemsg = 'PLAYER SAVED [ '..PlayerData.name..' ] ID: '..source..''
        QBCore.ShowSuccess(GetCurrentResourceName(), savemsg)
    else
        QBCore.ShowError(GetCurrentResourceName(), 'ERROR QBCORE.PLAYER.SAVE - PLAYERDATA IS EMPTY!')
    end
end

function QBCore.Player.SaveOffline(PlayerData)
    if PlayerData then
        MySQL.Async.insert('INSERT INTO players (citizenid, cid, license, name, money, charinfo, job, gang, position, metadata, company) VALUES (:citizenid, :cid, :license, :name, :money, :charinfo, :job, :gang, :position, :metadata, :company) ON DUPLICATE KEY UPDATE cid = :cid, name = :name, money = :money, charinfo = :charinfo, job = :job, gang = :gang, position = :position, metadata = :metadata, company = :company', {
            citizenid = PlayerData.citizenid,
            cid = tonumber(PlayerData.cid),
            license = PlayerData.license,
            name = PlayerData.name,
            money = json.encode(PlayerData.money),
            charinfo = json.encode(PlayerData.charinfo),
            job = json.encode(PlayerData.job),
            gang = json.encode(PlayerData.gang),
            position = json.encode(PlayerData.position),
            metadata = json.encode(PlayerData.metadata),
            company = json.encode(PlayerData.company),
        })
        if GetResourceState('qb-inventory') ~= 'missing' then exports['qb-inventory']:SaveInventory(PlayerData, true) end
        QBCore.ShowSuccess(GetCurrentResourceName(), PlayerData.name .. ' OFFLINE PLAYER SAVED!')
    else
        QBCore.ShowError(GetCurrentResourceName(), 'ERROR QBCORE.PLAYER.SAVEOFFLINE - PLAYERDATA IS EMPTY!')
    end
end

-- Delete character

local playertables = { -- Add tables as needed
    { table = 'players' },
    { table = 'apartments' },
    { table = 'bank_accounts' },
    { table = 'crypto_transactions' },
    { table = 'phone_invoices' },
    { table = 'phone_messages' },
    { table = 'playerskins' },
    { table = 'player_contacts' },
    { table = 'player_houses' },
    { table = 'player_mails' },
    { table = 'player_outfits' },
    { table = 'player_vehicles' }
}

function QBCore.Player.DeleteCharacter(source, citizenid)
    local license = QBCore.Functions.GetIdentifier(source, 'license')
    local result = MySQL.scalar.await('SELECT license FROM players where citizenid = ?', { citizenid })
    if license == result then
        local query = "DELETE FROM %s WHERE citizenid = ?"
        local tableCount = #playertables
        local queries = table.create(tableCount, 0)

        for i = 1, tableCount do
            local v = playertables[i]
            queries[i] = {query = query:format(v.table), values = { citizenid }}
        end

        MySQL.transaction(queries, function(result2)
            if result2 then
                TriggerEvent("Rc2-log:server:CreateLog", 'joinleave', 'Character Deleted', 'red', '**' .. GetPlayerName(source) .. '** ' .. license .. ' deleted **' .. citizenid .. '**..')
            end
        end)
    else
        DropPlayer(source, Lang:t("info.exploit_dropped"))
        TriggerEvent("Rc2-log:server:CreateLog", 'anticheat', 'Anti-Cheat', 'white', GetPlayerName(source) .. ' Has Been Dropped For Character Deletion Exploit', true)
    end
end

function QBCore.Player.ForceDeleteCharacter(citizenid)
    local result = MySQL.scalar.await('SELECT license FROM players where citizenid = ?', { citizenid })
    if result then
        local query = "DELETE FROM %s WHERE citizenid = ?"
        local tableCount = #playertables
        local queries = table.create(tableCount, 0)
        local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)

        if Player then
            DropPlayer(Player.PlayerData.source, "An admin deleted the character which you are currently using")
        end
        for i = 1, tableCount do
            local v = playertables[i]
            queries[i] = {query = query:format(v.table), values = { citizenid }}
        end

        MySQL.transaction(queries, function(result2)
            if result2 then
                TriggerEvent("Rc2-log:server:CreateLog", 'joinleave', 'Character Force Deleted', 'red', 'Character **' .. citizenid .. '** got deleted')
            end
        end)
    end
end

-- Inventory Backwards Compatibility

function QBCore.Player.SaveInventory(source)
    if GetResourceState('qb-inventory') == 'missing' then return end
    exports['qb-inventory']:SaveInventory(source, false)
end

function QBCore.Player.SaveOfflineInventory(PlayerData)
    if GetResourceState('qb-inventory') == 'missing' then return end
    exports['qb-inventory']:SaveInventory(PlayerData, true)
end

function QBCore.Player.GetTotalWeight(items)
    if GetResourceState('qb-inventory') == 'missing' then return end
    return exports['qb-inventory']:GetTotalWeight(items)
end

function QBCore.Player.GetSlotsByItem(items, itemName)
    if GetResourceState('qb-inventory') == 'missing' then return end
    return exports['qb-inventory']:GetSlotsByItem(items, itemName)
end

function QBCore.Player.GetFirstSlotByItem(items, itemName)
    if GetResourceState('qb-inventory') == 'missing' then return end
    return exports['qb-inventory']:GetFirstSlotByItem(items, itemName)
end

-- Util Functions

function QBCore.Player.CreateCitizenId()
    local UniqueFound = false
    local CitizenId = nil
    while not UniqueFound do
        local faz = math.random(1, 3)
        if faz == 1 then 
            CitizenId = tostring(QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomInt(1)):upper()
        elseif faz == 2 then 
            CitizenId = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomInt(2)):upper()
        elseif faz == 3 then 
            CitizenId = tostring(QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomInt(3)):upper()
        else
            CitizenId = tostring(QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomInt(4)):upper()
        end
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE citizenid = ?', { CitizenId })
        if result == 0 then
            UniqueFound = true
        end
    end
    return CitizenId
end

function QBCore.Functions.CreateAccountNumber()
    local UniqueFound = false
    local AccountNumber = nil
    while not UniqueFound do
        AccountNumber = 'US0' .. math.random(1, 9) .. 'OL' .. math.random(1111, 9999) .. math.random(1111, 9999) .. math.random(11, 99)
        local query = '%' .. AccountNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE charinfo LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return AccountNumber
end

function QBCore.Functions.CreatePhoneNumber()
    local UniqueFound = false
    local PhoneNumber = nil
    while not UniqueFound do
        PhoneNumber = '0' .. math.random(511111111, 599999999)
        local query = '%' .. PhoneNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE charinfo LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return PhoneNumber
end

function QBCore.Player.CreateFingerId()
    local UniqueFound = false
    local FingerId = nil
    while not UniqueFound do
        FingerId = tostring(QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(1) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(4))
        local query = '%' .. FingerId .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM `players` WHERE `metadata` LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return FingerId
end

function QBCore.Player.CreateWalletId()
    local UniqueFound = false
    local WalletId = nil
    while not UniqueFound do
        WalletId = 'FL-' .. math.random(11111111, 99999999)
        local query = '%' .. WalletId .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE metadata LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return WalletId
end

function QBCore.Player.CreateSerialNumber()
    local UniqueFound = false
    local SerialNumber = nil
    while not UniqueFound do
        SerialNumber = math.random(11111111, 99999999)
        local query = '%' .. SerialNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM players WHERE metadata LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return SerialNumber
end

--PaycheckInterval() -- This starts the paycheck system



