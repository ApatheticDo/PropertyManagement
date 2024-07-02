namespace PropertyManagement.ViewModels
{
    public class PropertyQRCodeModel
    {
        public string PropertyCode { get; set; }

        public string PropertyName { get; set; }

        public string Supplier { get; set; }

        public string Image { get; set; }

        public string GetDataForQrCode()
        {
            return $"{PropertyCode}, {PropertyName}, {Supplier}";
        }
    }
}
