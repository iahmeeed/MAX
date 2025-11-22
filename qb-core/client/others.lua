
QBCore.Scaleforms = {}
QBCore.Drilling = {}

-- Load QBCore.Scaleforms
QBCore.Scaleforms.LoadMovie = function(name)
  local scaleform = RequestScaleformMovie(name)
  while not HasScaleformMovieLoaded(scaleform) do Wait(0); end
  return scaleform
end

QBCore.Scaleforms.LoadInteractive = function(name)
  local scaleform = RequestScaleformMovieInteractive(name)
  while not HasScaleformMovieLoaded(scaleform) do Wait(0); end
  return scaleform
end

QBCore.Scaleforms.UnloadMovie = function(scaleform)
  SetScaleformMovieAsNoLongerNeeded(scaleform)
end

-- Text & labels
QBCore.Scaleforms.LoadAdditionalText = function(gxt,count)
  for i=0,count,1 do
    if not HasThisAdditionalTextLoaded(gxt,i) then
      ClearAdditionalText(i, true)
      RequestAdditionalText(gxt, i)
      while not HasThisAdditionalTextLoaded(gxt,i) do Wait(0); end
    end
  end
end

QBCore.Scaleforms.SetLabels = function(scaleform,labels)
  PushScaleformMovieFunction(scaleform, "SET_LABELS")
  for i=1,#labels,1 do
    local txt = labels[i]
    BeginTextCommandQBCore.Scaleformstring(txt)
    EndTextCommandQBCore.Scaleformstring()
  end
  PopScaleformMovieFunctionVoid()
end

-- Push method vals wrappers
QBCore.Scaleforms.PopMulti = function(scaleform,method,...)
  PushScaleformMovieFunction(scaleform,method)
  for _,v in pairs({...}) do
    local trueType = QBCore.Scaleforms.TrueType(v)
    if trueType == "string" then      
      PushScaleformMovieFunctionParameterString(v)
    elseif trueType == "boolean" then
      PushScaleformMovieFunctionParameterBool(v)
    elseif trueType == "int" then
      PushScaleformMovieFunctionParameterInt(v)
    elseif trueType == "float" then
      PushScaleformMovieFunctionParameterFloat(v)
    end
  end
  PopScaleformMovieFunctionVoid()
end

QBCore.Scaleforms.PopFloat = function(scaleform,method,val)
  PushScaleformMovieFunction(scaleform,method)
  PushScaleformMovieFunctionParameterFloat(val)
  PopScaleformMovieFunctionVoid()
end

QBCore.Scaleforms.PopInt = function(scaleform,method,val)
  PushScaleformMovieFunction(scaleform,method)
  PushScaleformMovieFunctionParameterInt(val)
  PopScaleformMovieFunctionVoid()
end

QBCore.Scaleforms.PopBool = function(scaleform,method,val)
  PushScaleformMovieFunction(scaleform,method)
  PushScaleformMovieFunctionParameterBool(val)
  PopScaleformMovieFunctionVoid()
end

-- Push no args
QBCore.Scaleforms.PopRet = function(scaleform,method)                
  PushScaleformMovieFunction(scaleform, method)
  return PopScaleformMovieFunction()
end

QBCore.Scaleforms.PopVoid = function(scaleform,method)
  PushScaleformMovieFunction(scaleform, method)
  PopScaleformMovieFunctionVoid()
end

-- Get return
QBCore.Scaleforms.RetBool = function(ret)
  return GetScaleformMovieFunctionReturnBool(ret)
end

QBCore.Scaleforms.RetInt = function(ret)
  return GetScaleformMovieFunctionReturnInt(ret)
end

-- Util functions
QBCore.Scaleforms.TrueType = function(val)
  if type(val) ~= "number" then return type(val); end

  local s = tostring(val)
  if string.find(s,'.') then 
    return "float"
  else
    return "int"
  end
end

QBCore.Drilling.DisabledControls = {30,31,32,33,34,35}

QBCore.Drilling.Start = function(callback)
  if not QBCore.Drilling.Active then
    QBCore.Drilling.Active = true
    QBCore.Drilling.Init()
    QBCore.Drilling.Update(callback)
  end
end

QBCore.Drilling.Init = function()
  if QBCore.Drilling.Scaleform then
    QBCore.Scaleforms.UnloadMovie(QBCore.Drilling.Scaleform)
  end

  QBCore.Drilling.Scaleform = QBCore.Scaleforms.LoadMovie("VAULT_DRILL")
  
  QBCore.Drilling.DrillSpeed = 0.0
  QBCore.Drilling.DrillPos   = 0.0
  QBCore.Drilling.DrillTemp  = 0.0
  QBCore.Drilling.HoleDepth  = 0.0

  QBCore.Scaleforms.PopVoid(QBCore.Drilling.Scaleform, "REVEAL")
  QBCore.Scaleforms.PopFloat(QBCore.Drilling.Scaleform,"SET_SPEED",           0.0)
  QBCore.Scaleforms.PopFloat(QBCore.Drilling.Scaleform,"SET_DRILL_POSITION",  0.0)
  QBCore.Scaleforms.PopFloat(QBCore.Drilling.Scaleform,"SET_TEMPERATURE",     0.0)
  QBCore.Scaleforms.PopFloat(QBCore.Drilling.Scaleform,"SET_HOLE_DEPTH",      0.0)
end

QBCore.Drilling.Update = function(callback)
  while QBCore.Drilling.Active do
    QBCore.Drilling.Draw()
    QBCore.Drilling.DisableControls()
    QBCore.Drilling.HandleControls()
    Wait(0)
  end
  callback(QBCore.Drilling.Result)
end

QBCore.Drilling.Draw = function()
  DrawScaleformMovieFullscreen(QBCore.Drilling.Scaleform,255,255,255,255,255)
end

QBCore.Drilling.HandleControls = function()
  local last_pos = QBCore.Drilling.DrillPos
  if IsControlJustPressed(0,172) then
    QBCore.Drilling.DrillPos = math.min(1.0,QBCore.Drilling.DrillPos + 0.01)
  elseif IsControlPressed(0,172) then
    QBCore.Drilling.DrillPos = math.min(1.0,QBCore.Drilling.DrillPos + (0.1 * GetFrameTime() / (math.max(0.1,QBCore.Drilling.DrillTemp) * 10)))
  elseif IsControlJustPressed(0,173) then
    QBCore.Drilling.DrillPos = math.max(0.0,QBCore.Drilling.DrillPos - 0.01)
  elseif IsControlPressed(0,173) then
    QBCore.Drilling.DrillPos = math.max(0.0,QBCore.Drilling.DrillPos - (0.1 * GetFrameTime()))
  end

  local last_speed = QBCore.Drilling.DrillSpeed
  if IsControlJustPressed(0,175) then
    QBCore.Drilling.DrillSpeed = math.min(1.0,QBCore.Drilling.DrillSpeed + 0.05)
  elseif IsControlPressed(0,175) then
    QBCore.Drilling.DrillSpeed = math.min(1.0,QBCore.Drilling.DrillSpeed + (0.5 * GetFrameTime()))
  elseif IsControlJustPressed(0,174) then
    QBCore.Drilling.DrillSpeed = math.max(0.0,QBCore.Drilling.DrillSpeed - 0.05)
  elseif IsControlPressed(0,174) then
    QBCore.Drilling.DrillSpeed = math.max(0.0,QBCore.Drilling.DrillSpeed - (0.5 * GetFrameTime()))
  end

  local last_temp = QBCore.Drilling.DrillTemp
  if last_pos < QBCore.Drilling.DrillPos then
    if QBCore.Drilling.DrillSpeed > 0.4 then
      QBCore.Drilling.DrillTemp = math.min(1.0,QBCore.Drilling.DrillTemp + ((0.05 * GetFrameTime()) *  (QBCore.Drilling.DrillSpeed * 10)))
      QBCore.Scaleforms.PopFloat(QBCore.Drilling.Scaleform,"SET_DRILL_POSITION",QBCore.Drilling.DrillPos)
    else
      if QBCore.Drilling.DrillPos < 0.1 or QBCore.Drilling.DrillPos < QBCore.Drilling.HoleDepth then
        QBCore.Scaleforms.PopFloat(QBCore.Drilling.Scaleform,"SET_DRILL_POSITION",QBCore.Drilling.DrillPos)
      else
        QBCore.Drilling.DrillPos = last_pos
        QBCore.Drilling.DrillTemp = math.min(1.0,QBCore.Drilling.DrillTemp + (0.01 * GetFrameTime()))
      end
    end
  else
    if QBCore.Drilling.DrillPos < QBCore.Drilling.HoleDepth then
      QBCore.Drilling.DrillTemp = math.max(0.0,QBCore.Drilling.DrillTemp - ( (0.05 * GetFrameTime()) *  math.max(0.005,(QBCore.Drilling.DrillSpeed * 10) /2)) )
    end

    if QBCore.Drilling.DrillPos ~= QBCore.Drilling.HoleDepth then
      QBCore.Scaleforms.PopFloat(QBCore.Drilling.Scaleform,"SET_DRILL_POSITION",QBCore.Drilling.DrillPos)
    end
  end

  if last_speed ~= QBCore.Drilling.DrillSpeed then
    QBCore.Scaleforms.PopFloat(QBCore.Drilling.Scaleform,"SET_SPEED",QBCore.Drilling.DrillSpeed)
  end

  if last_temp ~= QBCore.Drilling.DrillTemp then    
    QBCore.Scaleforms.PopFloat(QBCore.Drilling.Scaleform,"SET_TEMPERATURE",QBCore.Drilling.DrillTemp)
  end

  if QBCore.Drilling.DrillTemp >= 1.0 then
    QBCore.Drilling.Result = false
    QBCore.Drilling.Active = false
    QBCore.Scaleforms.PopVoid(QBCore.Drilling.Scaleform, "RESET")
  elseif QBCore.Drilling.DrillPos >= 1.0 then
    QBCore.Drilling.Result = true
    QBCore.Drilling.Active = false
    QBCore.Scaleforms.PopVoid(QBCore.Drilling.Scaleform, "RESET")
  end

  QBCore.Drilling.HoleDepth = (QBCore.Drilling.DrillPos > QBCore.Drilling.HoleDepth and QBCore.Drilling.DrillPos or QBCore.Drilling.HoleDepth)
end

QBCore.Drilling.DisableControls = function()
  for _,control in ipairs(QBCore.Drilling.DisabledControls) do
    DisableControlAction(0,control,true)
  end
end

QBCore.Drilling.EnableControls = function()
  for _,control in ipairs(QBCore.Drilling.DisabledControls) do
    DisableControlAction(0,control,true)
  end
end