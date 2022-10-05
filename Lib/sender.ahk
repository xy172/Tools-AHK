sender(data, asraw:= False)
{
    if asraw 
    {
        Send {Raw}%data%
    }
    else
    {
        Send %data%
    }
}